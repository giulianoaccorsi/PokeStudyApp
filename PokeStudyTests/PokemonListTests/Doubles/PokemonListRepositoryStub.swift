//
//  PokemonListRepositoryStub.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 08/08/24.
//

import Combine
@testable import PokeStudy

class PokemonListRepositoryStub: PokemonListRepositoryProtocol {

    var fetchPokemonDetailResult: Result<PokemonInfoResponse, Error>!
    var fetchPokemonsResult: Result<[PokemonEntity], Error>!

    func fetchPokemonDetail(for pokemon: String)
    -> AnyPublisher<PokemonInfoResponse, Error> {
        return fetchPokemonDetailResult
            .publisher
            .eraseToAnyPublisher()
    }

    func fetchPokemons(offset: Int)
    -> AnyPublisher<[PokemonEntity], Error> {
        return fetchPokemonsResult
            .publisher
            .eraseToAnyPublisher()
    }
}
