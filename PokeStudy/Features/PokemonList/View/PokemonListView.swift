//
//  PokemonListView.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 26/05/24.
//

import SwiftUI
import Kingfisher
import Lottie
import Combine

struct PokemonListView<ViewModel>: View where ViewModel: PokemonListViewModelProtocol {
    @StateObject var viewModel: ViewModel
    let retrySubject = PassthroughSubject<Void, Never>()

    var body: some View {
        ZStack {
            switch viewModel.loadingState {
            case .loading:
                LottieView(animation: .named("pokeballAnimation"))
                    .looping()

            case .loaded:
                buildPokemonList()

            case .failed:
                ErrorView(retrySubject: retrySubject)
            }
        }.onAppear {
            retrySubject.send()
        }
        .onReceive(retrySubject) { _ in
            viewModel.fetchPokemons()
        }
    }

    @ViewBuilder
    private func buildPokemonList() -> some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.pokemons, id: \.self) { pokemon in
                        NavigationLink(
                            destination: PokemonDetailBuilder.build(id: pokemon.id)
                        ) {
                            buildPokemonCell(pokemon)
                                .onAppear {
                                    if pokemon == viewModel.pokemons.last {
                                        viewModel.loadMorePokemons()
                                    }
                                }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func buildPokemonCell(_ pokemon: PokemonEntity) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(pokemon.number)
                    .foregroundStyle(.titleNumber)
                    .font(.semiBoldMonoSpaced(12))

                Text(pokemon.name)
                    .foregroundStyle(.text)
                    .font(.semiBoldMonoSpaced(24))

                HStack {
                    ForEach(pokemon.types, id: \.self) { type in
                        TypeView(
                            type: type,
                            font: .semiBoldMonoSpaced(13)
                        )
                        .frame(maxWidth: 100)
                    }
                }
            }
            .padding()

            Spacer()

            ZStack {
                Image(pokemon.background)
                KFImage.url(pokemon.image)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
            }
            .frame(maxWidth: 100)
            .padding()
        }
        .background(Color(pokemon.background))
        .cornerRadius(20)
        .padding(.horizontal, 3)
    }
}

#Preview {
    PokemonListBuilder.build()
}
