//
//  PokemonTypeResponse.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 08/08/24.
//

import Foundation

struct PokemonTypeResponse: Decodable {
    let damageRelations: DamageRelations

    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
    }

    struct DamageRelations: Decodable {
        let doubleDamage: [PokemonInfoResponse.ElementType]
        let halfDamage: [PokemonInfoResponse.ElementType]
        let noDamage: [PokemonInfoResponse.ElementType]

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case doubleDamage = "double_damage_from"
            case halfDamage = "half_damage_from"
            case noDamage = "no_damage_from"
        }
    }
}
