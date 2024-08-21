//
//  PokemonListConverterTest.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 08/08/24.
//

import XCTest
@testable import PokeStudy

class PokemonListConverterTests: XCTestCase {
    var sut: PokemonListConvertable!

    override func setUp() {
        super.setUp()
        sut = PokemonListConverter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testConvertSinglePokemonInfoResponse() {
        let response = PokemonInfoResponse.fixture()

        let entity = sut.convert(response)

        XCTAssertEqual(entity.id, response.id)
        XCTAssertEqual(entity.number, String(format: "Nº %03d", response.id))
        XCTAssertEqual(entity.name, response.name.capitalized)
        XCTAssertEqual(entity.types.first?.name, response.types.first?.type.name.rawValue.capitalized)
        XCTAssertEqual(entity.image, URL(string: response.sprites.frontDefault ?? ""))
        XCTAssertEqual(entity.background, response.types.first?.type.name.rawValue)
    }

    func testConvertPokemonInfoResponseList() {
        let responses: [PokemonInfoResponse] = [
            .fixture(),
            .fixture(
                id: 2,
                name: "Ivysaur"
            )
        ]

        let entities = sut.convert(responses)

        XCTAssertEqual(entities.count, responses.count)
        XCTAssertEqual(entities[0].id, responses[0].id)
        XCTAssertEqual(entities[1].name, responses[1].name.capitalized)
    }
}
