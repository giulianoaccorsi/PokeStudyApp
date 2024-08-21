//
//  String+Extensions.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 15/06/24.
//

import Foundation

extension String {
    func lastPathComponent() -> String? {
        let trimmedString = self.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        if let lastComponent = trimmedString.split(separator: "/").last {
            return String(lastComponent)
        }
        return nil
    }
}
