//
//  PokemonTypeEntity.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 27/07/24.
//

import Foundation

struct PokemonTypeEntity: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let logo: String
}
