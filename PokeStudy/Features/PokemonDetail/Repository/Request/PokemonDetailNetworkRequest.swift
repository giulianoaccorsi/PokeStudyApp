//
//  PokemonDetailNetworkRequest.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 17/06/24.
//

import Foundation
import CombineNetworking
import Commons

enum PokemonDetailNetworkRequest<Response: Decodable>: DataRequestProtocol {
    case info(id: Int)
    case specie(id: Int)
    case type(name: String)

    var domain: String {
        "https://pokeapi.co/api/v2"
    }

    var path: String {
        switch self {
        case .specie(let id):
            return "/pokemon-species/\(id)"
        case .type(name: let name):
            return "/type/\(name)"
        case .info(id: let id):
            return "/pokemon/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }
}
