//
//  PokemonDetailViewState.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 28/07/24.
//

import Foundation

enum PokemonDetailViewState {
    case loading
    case loaded(PokemonDetailEntity)
    case failed
}
