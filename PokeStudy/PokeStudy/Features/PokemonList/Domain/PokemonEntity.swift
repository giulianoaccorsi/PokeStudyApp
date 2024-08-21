//
//  PokemonEntity.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 25/07/24.
//

import Foundation

struct PokemonEntity: Equatable, Hashable {
    let id: Int
    let number: String
    let name: String
    let types: [PokemonTypeEntity]
    let image: URL?
    let background: String
}
