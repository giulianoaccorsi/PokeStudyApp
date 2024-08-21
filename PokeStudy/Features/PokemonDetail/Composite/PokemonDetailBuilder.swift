//
//  PokemonDetailBuilder.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 28/07/24.
//

import Foundation

enum PokemonDetailBuilder {
    static func build(id: Int) -> PokemonDetailView<PokemonDetailViewModel> {
        let viewModel = PokemonDetailViewModel(
            repository: PokemonDetailRepository(),
            converter: PokemonDetailConverter(),
            id: id
        )

        return .init(viewModel: viewModel)
    }
}
