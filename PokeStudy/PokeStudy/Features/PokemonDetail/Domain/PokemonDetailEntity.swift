//
//  PokemonDetailEntity.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 27/07/24.
//

import Foundation

struct PokemonDetailEntityResponse {
    let information: PokemonSpecieResponse
    let pokemon: PokemonInfoResponse
}

struct PokemonDetailEntity {
    let name: String
    let sound: String
    let type: [PokemonTypeEntity]
    let logo: String
    let background: String
    let image: URL?
    let number: String
    let weight: String
    let height: String
    let category: String
    let textDescription: String
    let skill: String
}
