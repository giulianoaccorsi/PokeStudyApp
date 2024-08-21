//
//  PokemonInfoResponse+Fixture.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 08/08/24.
//

import Foundation
@testable import PokeStudy

extension PokemonInfoResponse {
    static func fixture(
        id: Int = 1,
        name: String = "Bulbasaur",
        order: Int = 1,
        weight: Int = 60,
        height: Int = 4,
        cries: PokemonInfoResponse.Cries = .init(latest: ""),
        sprites: PokemonInfoResponse.Sprite = .init(frontDefault: ""),
        types: [PokemonInfoResponse.SlotTypes] = [.init(type: .init(name: .grass))],
        abilities: [PokemonInfoResponse.Abilities] = [.init(ability: .init(name: "static"))]
    ) -> PokemonInfoResponse {
        return PokemonInfoResponse(
            id: id,
            name: name,
            order: order,
            weight: weight,
            height: height,
            cries: cries,
            sprites: sprites,
            types: types,
            abilities: abilities
        )
    }
}
