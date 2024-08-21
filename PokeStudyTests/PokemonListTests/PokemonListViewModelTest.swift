//
//  PokeStudyTests.swift
//  PokeStudyTests
//
//  Created by Giuliano Accorsi on 08/08/24.
//

import XCTest
import Combine
@testable import PokeStudy

class PokemonListViewModelTest: XCTestCase {
    var sut: PokemonListViewModel!
    var repository: PokemonListRepositoryStub!

    override func setUp() {
        super.setUp()
        repository = PokemonListRepositoryStub()
        sut = PokemonListViewModel(
            repository: repository
        )
    }
    override func tearDown() {
        super.tearDown()
        sut = nil
        repository = nil
    }

    func testFetchPokemonsIncreasesPokemonsCountByTwo() {
        let expectation = XCTestExpectation(description: "Pokemons fetched")
        repository.fetchPokemonsResult = .success([.fixture(), .fixture()])
        sut.fetchPokemons()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.pokemons.count, 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPokemonsCallingTwoTimeShouldPokemonsCountByTwo() {
        let expectation1 = XCTestExpectation(description: "First fetch")
        let expectation2 = XCTestExpectation(description: "Second fetch")

        repository.fetchPokemonsResult = .success([.fixture(), .fixture()])

        sut.fetchPokemons()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.pokemons.count, 2)
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 1.0)

        sut.fetchPokemons()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.pokemons.count, 2)
            expectation2.fulfill()
        }

        wait(for: [expectation2], timeout: 1.0)
    }

    func testFetchPokemonsAndLoreMoreShouldPokemonsCountByFour() {
        let expectation1 = XCTestExpectation(description: "loadMorePokemons")

        repository.fetchPokemonsResult = .success([.fixture(), .fixture()])

        var subscriptions = Set<AnyCancellable>()
        sut.$pokemons.sink { pokemon in
            if pokemon.count == 4 {
                expectation1.fulfill()
            }
        }
        .store(in: &subscriptions)

        sut.fetchPokemons()
        sut.loadMorePokemons()
        wait(for: [expectation1], timeout: 1)
    }

    func testFetchPokemonsShouldSortById() {
        let expectation = XCTestExpectation(description: "Pokemons are sorted by ID")

        let pokemon1 = PokemonEntity.fixture(id: 10)
        let pokemon2 = PokemonEntity.fixture(id: 5)
        let pokemon3 = PokemonEntity.fixture(id: 20)

        repository.fetchPokemonsResult = .success([pokemon1, pokemon2, pokemon3])

        sut.fetchPokemons()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.pokemons.map { $0.id }, [5, 10, 20])
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadingStateChangesDuringFetch() {
        let expectation1 = XCTestExpectation(description: "Loading state is loading")
        let expectation2 = XCTestExpectation(description: "Loading state is loaded")
        var cancellables:Set<AnyCancellable> = []

        repository.fetchPokemonsResult = .success([.fixture(), .fixture()])

        sut.$loadingState
            .sink { state in
                if state == .loading {
                    expectation1.fulfill()
                }
                if state == .loaded {
                    expectation2.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.fetchPokemons()

        wait(for: [expectation1, expectation2], timeout: 1.0)
    }

    func testFetchPokemonsFailureShouldSetFailedState() {
        let expectation = XCTestExpectation(description: "Loading state is failed")
        var cancellables:Set<AnyCancellable> = []

        repository.fetchPokemonsResult = .failure(NSError(domain: "TestError", code: 1))

        sut.$loadingState
            .sink { state in
                if case .failed = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.fetchPokemons()

        wait(for: [expectation], timeout: 1.0)
    }
}
