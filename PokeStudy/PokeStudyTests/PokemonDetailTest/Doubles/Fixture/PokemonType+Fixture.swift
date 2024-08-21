//
//  PokemonType+Fixture.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 10/08/24.
//

import Foundation
@testable import PokeStudy

extension PokemonTypeResponse {
    static func fixture(
        damageRelations: DamageRelations = DamageRelations.fixture()
    ) -> PokemonTypeResponse {
        return PokemonTypeResponse(
            damageRelations: damageRelations
        )
    }
}

extension PokemonTypeResponse.DamageRelations {
    static func fixture(
        doubleDamage: [PokemonInfoResponse.ElementType] = [
            PokemonInfoResponse.ElementType(name: .fire),
            PokemonInfoResponse.ElementType(name: .water)
        ],
        halfDamage: [PokemonInfoResponse.ElementType] = [
            PokemonInfoResponse.ElementType(name: .grass),
            PokemonInfoResponse.ElementType(name: .electric)
        ],
        noDamage: [PokemonInfoResponse.ElementType] = [
            PokemonInfoResponse.ElementType(name: .ground)
        ]
    ) -> PokemonTypeResponse.DamageRelations {
        return PokemonTypeResponse.DamageRelations(
            doubleDamage: doubleDamage,
            halfDamage: halfDamage,
            noDamage: noDamage
        )
    }
}
