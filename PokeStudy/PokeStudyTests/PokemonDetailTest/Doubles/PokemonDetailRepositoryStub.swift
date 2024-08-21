//
//  PokemonDetailRepositoryStub.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 10/08/24.
//

import Combine
@testable import PokeStudy

class PokemonDetailRepositoryStub: PokemonDetailRepositoryProtocol {

    var pokemonDetailEntityResponse: Result<
        PokemonDetailEntityResponse,
        Error> = .success(.fixture())

    var pokemonTypeResponse: Result<
        PokemonTypeResponse,
        Error> = .success(.fixture())

    func fetchPokemon(id: Int) -> AnyPublisher<PokeStudy.PokemonDetailEntityResponse, any Error> {
        return pokemonDetailEntityResponse
            .publisher
            .eraseToAnyPublisher()
    }

    func fetchWeakness(name: String) -> AnyPublisher<PokeStudy.PokemonTypeResponse, any Error> {
        return pokemonTypeResponse
            .publisher
            .eraseToAnyPublisher()
    }
}
