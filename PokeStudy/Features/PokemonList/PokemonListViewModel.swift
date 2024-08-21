//
//  PokemonListViewModel.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 28/05/24.
//

import Foundation
import CombineNetworking
import Combine

protocol PokemonListViewModelProtocol: ObservableObject {
    var pokemons: [PokemonEntity] { get set }
    var loadingState: PokemonListViewState { get set }

    func fetchPokemons()
    func loadMorePokemons()

}

final class PokemonListViewModel: PokemonListViewModelProtocol {
    @Published var pokemons: [PokemonEntity] = []
    @Published var loadingState: PokemonListViewState = .loading

    private let repository: PokemonListRepositoryProtocol
    private var cancellable = Set<AnyCancellable>()
    private var offsetPokemon = 0
    private var isLoadingMore = false

    init(
        repository: PokemonListRepositoryProtocol
    ) {
        self.repository = repository
    }

    func fetchPokemons() {
        reset()
        isLoadingMore = false
        loadPokemons()
    }

    func loadMorePokemons() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        offsetPokemon += 20
        loadPokemons()
    }

    private func loadPokemons() {
        repository.fetchPokemons(offset: offsetPokemon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoadingMore = false
                    self?.loadingState = .loaded
                case .failure(let error):
                    self?.handleError(error)
                }
            }, receiveValue: { [weak self] pokemonList in
                guard let self else { return }
                self.pokemons.append(contentsOf: pokemonList)
                self.sortPokemons()
            })
            .store(in: &cancellable)
    }

    private func reset() {
        pokemons.removeAll()
        offsetPokemon = 0
        loadingState = .loading
    }

    private func handleError(_ error: Error) {
        loadingState = .failed
        isLoadingMore = false
    }

    private func sortPokemons() {
        pokemons.sort { $0.id < $1.id }
    }
}
