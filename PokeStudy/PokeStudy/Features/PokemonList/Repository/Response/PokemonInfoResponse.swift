//
//  PokemonInfoResponse.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 08/08/24.
//

import Foundation

struct PokemonInfoResponse: Codable, Hashable {
    let id: Int
    let name: String
    let order: Int
    let weight: Int
    let height: Int
    let cries: Cries
    let sprites: Sprite
    let types: [SlotTypes]
    let abilities: [Abilities]

    struct Cries: Codable, Hashable {
        let latest: String
    }

    struct Abilities: Codable, Hashable {
        let ability: Ability
    }

    struct Ability: Codable, Hashable {
        let name: String
    }

    struct Sprite: Codable, Hashable {
        let frontDefault: String?

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct SlotTypes: Codable, Hashable {
        let type: ElementType
    }

    struct ElementType: Codable, Hashable {
        let name: PokemonType
    }

    enum PokemonType: String, Codable {
        case normal
        case fire
        case water
        case electric
        case grass
        case ice
        case fighting
        case poison
        case ground
        case flying
        case psychic
        case bug
        case rock
        case ghost
        case dragon
        case dark
        case steel
        case fairy
    }
}
