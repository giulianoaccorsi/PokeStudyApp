//
//  PokemonListConverter.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 25/07/24.
//

import Foundation

protocol PokemonListConvertable {
    func convert(_ response: PokemonInfoResponse) -> PokemonEntity
    func convert(_ pokemonList: [PokemonInfoResponse]) -> [PokemonEntity]
}

struct PokemonListConverter: PokemonListConvertable {
    func convert(_ response: PokemonInfoResponse) -> PokemonEntity {
        .init(
            id: response.id,
            number: response.id.formatToPokemonNumber(),
            name: response.name.capitalized,
            types: convert(response.types),
            image: URL(string: response.sprites.frontDefault ?? ""),
            background: response.types.first?.type.name.rawValue ?? ""
        )
    }

    func convert(_ pokemonList: [PokemonInfoResponse]) -> [PokemonEntity] {
        pokemonList.map {
            convert($0)
        }
    }

    private func convert(_ types: [PokemonInfoResponse.SlotTypes]) -> [PokemonTypeEntity] {
        types.map {
            .init(
                name: "\($0.type.name.rawValue.capitalized)",
                logo: "\($0.type.name.rawValue)Logo"
            )
        }
    }
}
