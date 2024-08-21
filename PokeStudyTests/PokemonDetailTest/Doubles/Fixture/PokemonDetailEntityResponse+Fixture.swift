//
//  PokemonDetailEntityResponse+Fixture.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 10/08/24.
//

import Combine
@testable import PokeStudy

extension PokemonDetailEntityResponse {
    static func fixture(
        information: PokemonSpecieResponse = PokemonSpecieResponse.fixture(),
        pokemon: PokemonInfoResponse = PokemonInfoResponse.fixture()
    ) -> PokemonDetailEntityResponse {
        return PokemonDetailEntityResponse(
            information: information,
            pokemon: pokemon
        )
    }
}

