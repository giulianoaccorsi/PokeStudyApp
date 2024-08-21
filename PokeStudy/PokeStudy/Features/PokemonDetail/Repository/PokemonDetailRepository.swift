//
//  PokemonDetailRepository.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 28/07/24.
//

import Foundation
import CombineNetworking
import Combine

protocol PokemonDetailRepositoryProtocol {
    func fetchPokemon(id: Int) -> AnyPublisher<PokemonDetailEntityResponse, Error>
    func fetchWeakness(name: String) -> AnyPublisher<PokemonTypeResponse, Error>
}

final class PokemonDetailRepository: PokemonDetailRepositoryProtocol {
    private let service: NetworkService

    init(service: NetworkService = DefaultNetworkService()) {
        self.service = service
    }
    func fetchPokemon(id: Int) -> AnyPublisher<PokemonDetailEntityResponse, any Error> {
        let pokemonDetailPublisher = fetchPokemonDetail(for: id)
        let informationPublisher = fetchInformation(id: id)

        return Publishers.Zip(pokemonDetailPublisher, informationPublisher)
            .map {
                PokemonDetailEntityResponse(
                    information: $1,
                    pokemon: $0
                )
            }.eraseToAnyPublisher()
    }

    func fetchWeakness(name: String) -> AnyPublisher<PokemonTypeResponse, Error> {
        service.request(
            PokemonDetailNetworkRequest<PokemonTypeResponse>
                .type(name: name)
        )
    }

    private func fetchPokemonDetail(for pokemon: Int) -> AnyPublisher<PokemonInfoResponse, Error> {
        service.request(
            PokemonDetailNetworkRequest<PokemonInfoResponse>
                .info(id: pokemon)
        )
    }

    private func fetchInformation(id: Int) -> AnyPublisher<PokemonSpecieResponse, Error> {
        service.request(
            PokemonDetailNetworkRequest<PokemonSpecieResponse>
                .specie(id: id)
        )
    }
}
