//
//  PokemonTypeResponse.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 17/06/24.
//

import Foundation

struct PokemonSpecieResponse: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    let genera: [Genus]

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
        case genera
    }

    struct Language: Codable {
        let name: String
    }

    struct Genus: Codable {
        let genus: String
        let language: Language
    }

    struct FlavorTextEntry: Codable {
        let flavorText: String
        let language: Language

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }
}
