//
//  PokemonListResponse.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 26/05/24.
//

struct ResultsResponse: Decodable {
    let results: [PokemonResponse]

    struct PokemonResponse: Decodable, Hashable {
        let name: String
        let url: String
    }
}
