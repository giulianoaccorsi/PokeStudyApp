//
//  PokemonListNetworkRequest.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 26/05/24.
//

import Foundation
import CombineNetworking

enum PokemonListNetworkRequest<Response: Decodable>: DataRequestProtocol {
    case pokedexResult(offSet: Int)
    case pokemonDetail(id: String)

    var domain: String {
        "https://pokeapi.co/api/v2"
    }

    var path: String {
        switch self {
        case .pokedexResult:
            return "/pokemon"
        case .pokemonDetail(let id):
            return "/pokemon/\(id)"
        }
    }

    var queryItems: [String: String] {
        switch self {
        case .pokedexResult(let offSet):
            [
                "limit": "20",
                "offset": "\(offSet)"
            ]
        case .pokemonDetail:
            [:]
        }
    }

    var method: HTTPMethod {
        .get
    }
}
