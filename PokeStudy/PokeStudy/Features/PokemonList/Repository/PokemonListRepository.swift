//
//  PokemonListRepository.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 29/06/24.
//

import Foundation
import CombineNetworking
import Combine

protocol PokemonListRepositoryProtocol {
    func fetchPokemonDetail(for pokemon: String)
    -> AnyPublisher<PokemonInfoResponse, Error>

    func fetchPokemons(offset: Int)
    -> AnyPublisher<[PokemonEntity], Error>

}

final class PokemonListRepository: PokemonListRepositoryProtocol {
    private let service: NetworkService
    private let converter: PokemonListConvertable

    init(
        service: NetworkService,
        converter: PokemonListConvertable
    ) {
        self.service = service
        self.converter = converter
    }

    func fetchPokemonDetail(for pokemon: String) -> AnyPublisher<PokemonInfoResponse, Error> {
        service.request(
            PokemonListNetworkRequest<PokemonInfoResponse>
                .pokemonDetail(id: pokemon)
        )
    }

    func fetchPokemons(offset: Int) -> AnyPublisher<[PokemonEntity], Error> {
        service.request(PokemonListNetworkRequest<ResultsResponse>.pokedexResult(offSet: offset))
            .map { $0.results }
            .flatMap { pokemons in
                Publishers.MergeMany(pokemons.map { pokemon in
                    self.fetchPokemonDetail(for: (pokemon.url as NSString).lastPathComponent)
                })
                .collect()
            }
            .map { pokemonResponse in
                pokemonResponse.map { response in
                    self.converter.convert(response)
                }

            }
            .eraseToAnyPublisher()
    }
}
