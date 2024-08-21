//
//  PokeStudyApp.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 25/05/24.
//

import SwiftUI

@main
struct PokeStudyApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonListBuilder.build()
        }
    }
}
