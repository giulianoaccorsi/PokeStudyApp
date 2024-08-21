//
//  PokemonDetailConverterTest.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 20/08/24.
//

import XCTest
@testable import PokeStudy

final class PokemonDetailConverterTests: XCTestCase {

    var converter: PokemonDetailConvertable!

    override func setUp() {
        super.setUp()
        converter = PokemonDetailConverter()
    }

    override func tearDown() {
        converter = nil
        super.tearDown()
    }

    func testConvertResponseToEntity() {
        let response = PokemonDetailEntityResponse.fixture()
        let entity = converter.convert(response)

        XCTAssertEqual(entity.name, response.pokemon.name.capitalized)
        XCTAssertEqual(entity.sound, response.pokemon.cries.latest)
        XCTAssertEqual(entity.logo, "\(response.pokemon.types.first?.type.name.rawValue ?? "")Logo")
        XCTAssertEqual(entity.background, "\(response.pokemon.types.first?.type.name.rawValue ?? "")")
        XCTAssertEqual(entity.number, response.pokemon.id.formatToPokemonNumber())
        XCTAssertEqual(entity.weight, response.pokemon.weight.formWeightToKilogram())
        XCTAssertEqual(entity.height, response.pokemon.height.formatHeightToMeter())
        XCTAssertEqual(entity.skill, response.pokemon.abilities.first?.ability.name.capitalized ?? "")
        XCTAssertEqual(entity.image, URL(string: response.pokemon.sprites.frontDefault ?? ""))
    }

    func testConvertDamageRelationsToPokemonTypes() {
        let damageRelations: [String: Int] = [
            "fire": 2,
            "water": 1,
            "electric": 0
        ]

        let types = converter.convert(damageRelations)

        XCTAssertEqual(types.count, 1)
        XCTAssertEqual(types.first?.name, "Fire")
        XCTAssertEqual(types.first?.logo, "fireLogo")
    }

    func testExtractCategory() {
        let response = PokemonDetailEntityResponse.fixture()
        let entity = converter.convert(response)
        XCTAssertEqual(entity.category, "Seed")
    }
}
