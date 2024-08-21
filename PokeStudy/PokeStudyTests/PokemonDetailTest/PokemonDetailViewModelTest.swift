//
//  PokemonDetailTest.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 10/08/24.
//
import XCTest
import Combine
@testable import PokeStudy

final class PokemonDetailViewModelTests: XCTestCase {

    private var viewModel: PokemonDetailViewModel!
    private var repositoryMock: PokemonDetailRepositoryStub!
    private var converterMock: PokemonDetailConverter!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        repositoryMock = PokemonDetailRepositoryStub()
        converterMock = PokemonDetailConverter()
        viewModel = PokemonDetailViewModel(
            repository: repositoryMock,
            converter: converterMock,
            id: 1
        )
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        repositoryMock = nil
        converterMock = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchPokemonDetailSuccess() {
        let pokemonResponse = PokemonDetailEntityResponse.fixture()
        let pokemonDetail = converterMock.convert(pokemonResponse)

        let expectation = XCTestExpectation(description: "Loading state changes to .loaded")

        viewModel.$loadingState
            .dropFirst()
            .sink { state in
                if case .loaded(let entity) = state {
                    XCTAssertEqual(entity.name, pokemonDetail.name)
                    XCTAssertEqual(entity.textDescription, pokemonDetail.textDescription)
                    XCTAssertEqual(entity.number, pokemonDetail.number)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchPokemonDetail()
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPokemonDetailError() {
        repositoryMock.pokemonDetailEntityResponse = .failure(NSError(domain: "Error", code: 400))

        let expectation = XCTestExpectation(description: "Loading state changes to .failed")

        viewModel.$loadingState
            .dropFirst(2)
            .sink { state in
                if case .failed = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchPokemonDetail()
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPokemonWeaknesses() {
        repositoryMock.pokemonDetailEntityResponse = .success(.fixture())
        repositoryMock.pokemonTypeResponse = .success(.fixture())

        let expectation = XCTestExpectation(description: "Pokemon weaknesses are calculated correctly")

        viewModel.$pokemonWeakness
            .dropFirst()
            .sink { weaknesses in
                let sortedWeaknesses = weaknesses.sorted(by: { $0.name < $1.name })

                XCTAssertEqual(sortedWeaknesses.count, 2)
                XCTAssertEqual(sortedWeaknesses.first?.name, "Fire")
                XCTAssertEqual(sortedWeaknesses.last?.name, "Water")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchPokemonDetail()
    }
}
