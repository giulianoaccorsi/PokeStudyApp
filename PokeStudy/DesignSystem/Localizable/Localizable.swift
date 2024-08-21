//
//  Localizable.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 11/08/24.
//

import Foundation

@propertyWrapper
struct Localizable {
    var wrappedValue: String {
        didSet {
            wrappedValue = String(localized: String.LocalizationValue(wrappedValue))
        }
    }

    init(wrappedValue: String) {
        self.wrappedValue = String(localized: String.LocalizationValue(wrappedValue))
    }
}

enum Strings {

    // MARK: - Error View
    @Localizable static var errorTitle = "ErrorTitle"
    @Localizable static var errorDescription = "ErrorDescription"
    @Localizable static var errorPrimaryButton = "ErrorButton"

    // MARK: - Detail View
    @Localizable static var detailWeight = "DetailWeight"
    @Localizable static var detailHeight = "DetailHeight"
    @Localizable static var detailCategory = "DetailCategory"
    @Localizable static var detailAbility = "DetailAbility"
    @Localizable static var detailWeakness = "DetailWeakness"
}
