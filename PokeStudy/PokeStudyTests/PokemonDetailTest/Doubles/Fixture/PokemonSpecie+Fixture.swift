//
//  PokemonSpecie+Fixture.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 10/08/24.
//

import Foundation
@testable import PokeStudy

extension PokemonSpecieResponse {
    static func fixture(
        flavorTextEntries: [FlavorTextEntry] = [
            FlavorTextEntry(
                flavorText: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
                language: Language(name: "en")
            ),
            FlavorTextEntry(
                flavorText: "種子ポケモン",
                language: Language(name: "ja")
            )
        ],
        genera: [Genus] = [
            Genus(
                genus: "Seed Pokémon",
                language: Language(name: "en")
            ),
            Genus(
                genus: "たねポケモン",
                language: Language(name: "ja")
            )
        ]
    ) -> PokemonSpecieResponse {
        return PokemonSpecieResponse(
            flavorTextEntries: flavorTextEntries,
            genera: genera
        )
    }
}
