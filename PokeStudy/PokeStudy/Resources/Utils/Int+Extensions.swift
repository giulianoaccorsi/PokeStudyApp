//
//  Int+Extensions.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 11/08/24.
//

import Foundation

extension Int {
    func formatToPokemonNumber() -> String {
        return String(format: "Nº %03d", self)
    }

    func formWeightToKilogram() -> String {
        return String(format: "%.2f kg", Double(self) / 10)
    }

    func formatHeightToMeter() -> String {
        return String(format: "%.2f m", Double(self) / 10)
    }
}
