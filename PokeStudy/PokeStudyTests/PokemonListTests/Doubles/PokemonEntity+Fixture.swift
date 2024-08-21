//
//  PokemonInfoResponse+Fixture.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 08/08/24.
//

import Combine
import Foundation
@testable import PokeStudy

extension PokemonEntity {
    static func fixture(
            id: Int = 1,
            number: String = "001",
            name: String = "Bulbasaur",
            types: [PokemonTypeEntity] = [
                PokemonTypeEntity(name: "grass", logo: "grassLogo"),
                PokemonTypeEntity(name: "poison", logo: "poisonLogo")
            ],
            image: URL? = URL(string: "https://example.com/bulbasaur.png"),
            background: String = "green"
        ) -> PokemonEntity {
            return PokemonEntity(
                id: id,
                number: number,
                name: name,
                types: types,
                image: image,
                background: background
            )
        }
}
