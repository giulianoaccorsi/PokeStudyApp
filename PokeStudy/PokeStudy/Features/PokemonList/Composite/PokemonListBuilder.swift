//
//  PokemonListBuilder.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 27/07/24.
//

import Foundation
import CombineNetworking

enum PokemonListBuilder {
    static func build() -> PokemonListView<PokemonListViewModel> {

        let repository = PokemonListRepository(
            service: DefaultNetworkService(),
            converter: PokemonListConverter()
        )

        let viewModel: PokemonListViewModel = .init(
            repository: repository
        )

        return .init(viewModel: viewModel)
    }
}
