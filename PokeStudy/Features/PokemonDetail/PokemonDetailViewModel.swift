//
//  PokemonDetailViewMode.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 27/07/24.
//

import Foundation
import CombineNetworking
import Combine

protocol PokemonDetailViewModelProtocol: ObservableObject {
    var loadingState: PokemonDetailViewState { get set }
    var pokemonDetailEntity: PokemonDetailEntity? { get set }
    var pokemonWeakness: [PokemonTypeEntity] { get }

    func fetchPokemonDetail()
}

final class PokemonDetailViewModel: PokemonDetailViewModelProtocol {
    @Published var loadingState: PokemonDetailViewState = .loading
    @Published var pokemonDetailEntity: PokemonDetailEntity?
    @Published var pokemonWeakness: [PokemonTypeEntity] = []

    private var cancellable = Set<AnyCancellable>()

    private let repository: PokemonDetailRepositoryProtocol
    private let converter: PokemonDetailConvertable
    private let id: Int
    private var typeWeaknesses: [String: Int] = [:]

    init(
        repository: PokemonDetailRepositoryProtocol,
        converter: PokemonDetailConvertable,
        id: Int
    ) {
        self.repository = repository
        self.id = id
        self.converter = converter
    }

    func fetchPokemonDetail() {
        self.loadingState = .loading
        repository.fetchPokemon(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.loadingState = .failed
                }
            }, receiveValue: { [weak self] pokemonResponse in
                guard let self else { return }
                self.fetchWeakness(converter.convert(pokemonResponse))
            })
            .store(in: &cancellable)
    }

    func fetchWeakness(_ pokemonDetail: PokemonDetailEntity) {
        loadingState = .loading
        let group = DispatchGroup()

        for typeElement in pokemonDetail.type {
            group.enter()
            repository.fetchWeakness(name: typeElement.name.lowercased())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.loadingState = .failed
                    group.leave()
                }
            } receiveValue: { [weak self] pokemonType in
                self?.processDamageRelations(pokemonType.damageRelations)
                group.leave()
            }
            .store(in: &cancellable)
        }

        group.notify(queue: .main) { [weak self] in
            guard let self else { return }

            if case .loading = self.loadingState {
                self.pokemonWeakness = self.converter.convert(self.typeWeaknesses)
                self.loadingState = .loaded(pokemonDetail)
            }
        }
    }

    private func processDamageRelations(_ damageRelations: PokemonTypeResponse.DamageRelations) {
        for damage in damageRelations.doubleDamage {
            typeWeaknesses[damage.name.rawValue, default: 1] *= 2
        }
        for damage in damageRelations.halfDamage {
            typeWeaknesses[damage.name.rawValue, default: 1] /= 2
        }
        for damage in damageRelations.noDamage {
            typeWeaknesses[damage.name.rawValue] = 0
        }
    }
}
