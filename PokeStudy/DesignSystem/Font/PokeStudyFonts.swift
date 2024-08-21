//
//  File.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 15/08/24.
//

import SwiftUI

extension Font {
    static func pokemon(_ size: CGFloat) -> Font {
        Font.custom(
            "PokemonEmerald",
            size: size
        )
    }

    static func pokemonRBY(_ size: CGFloat) -> Font {
        Font.custom(
            "PKMN RBYGSC",
            size: size
        )
    }

    static func semiBoldMonoSpaced(_ size: CGFloat) -> Font {
        Font.system(
            size: size,
            weight: .semibold,
            design: .monospaced
        )
    }
}
