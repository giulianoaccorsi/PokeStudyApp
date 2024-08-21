//
//  PokemonDetail.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 16/06/24.
//

import SwiftUI
import Kingfisher
import Lottie
import Combine

struct PokemonDetailView<ViewModel>: View where ViewModel: PokemonDetailViewModelProtocol {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ViewModel
    @StateObject private var audioPlayer = AudioPlayer()

    let retrySubject = PassthroughSubject<Void, Never>()

    var body: some View {
        ZStack {
            switch viewModel.loadingState {
            case .loading:
                LottieView(animation: .named("pokeballAnimation"))
                    .looping()
            case .loaded(let entity):
                buildPokemonDetailView(entity)
            case .failed:
                ErrorView(retrySubject: retrySubject)
            }
        }.onAppear {
            viewModel.fetchPokemonDetail()
        }
        .onReceive(retrySubject) { _ in
            viewModel.fetchPokemonDetail()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: buildBackButton())
        .onBackSwipe {
            presentationMode.wrappedValue.dismiss()
        }

    }

    @ViewBuilder
    private func buildPokemonDetailView(_ entity: PokemonDetailEntity) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                buildPokemonHeader(entity)
                buildPokemonTitle(entity)
                buildGridInformationView(entity)
                buildWeaknewssView()
                Spacer()
            }
            .onAppear {
                audioPlayer.setupAudioSession()
                audioPlayer.playSound(from: entity.sound)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .toolbarBackground(Color.clear, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .background(Color(entity.background))
    }

    @ViewBuilder
    private func buildPokemonHeader(_ entity: PokemonDetailEntity) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(Color(entity.logo).opacity(0.6))
                .frame(height: 250)
                .scaleEffect(2)
                .offset(y: -150)
                .overlay {
                    Image(entity.logo)
                        .renderingMode(.template)
                        .foregroundStyle(Color.white.opacity(0.6))
                }
            KFImage.url(entity.image)
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(y: 70)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func buildPokemonTitle(_ entity: PokemonDetailEntity) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(entity.name)
                    .font(.semiBoldMonoSpaced(32))

                Text(entity.number)
                    .foregroundStyle(.titleNumber)
                    .font(.semiBoldMonoSpaced(16))
                    .padding(.bottom)
            }
            .padding(.horizontal)

            HStack {
                ForEach(entity.type, id: \.self) { type in
                    TypeView(
                        type: type,
                        font: .semiBoldMonoSpaced(12)
                    )
                        .frame(maxWidth: 100)
                }
            }
            .padding(.horizontal)

            Text(entity.textDescription)
                .foregroundStyle(.text)
                .font(.pokemon(20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
    }

    @ViewBuilder
    private func buildGridInformationView(_ entity: PokemonDetailEntity) -> some View {
        let columns = [
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0)
        ]

        LazyVGrid(columns: columns, spacing: 15) {
            InformationView(
                image: .weight,
                title: Strings.detailWeight,
                text: entity.weight
            )

            InformationView(
                image: .height,
                title: Strings.detailHeight,
                text: entity.height
            )

            InformationView(
                image: .category,
                title: Strings.detailCategory,
                text: entity.category
            )

            InformationView(
                image: .pokeball,
                title: Strings.detailAbility,
                text: entity.skill
            )
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func buildBackButton() -> some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("back")
                .resizable()
                .scaledToFit()
                .frame(width: 44)
        }
    }

    @ViewBuilder
    private func buildWeaknewssView() -> some View {
        VStack(alignment: .leading) {
            Text(Strings.detailWeakness)
                .foregroundStyle(.text)
                .font(
                    .semiBoldMonoSpaced(18)
                )
            buildWeaknewssGridView()
        }
        .padding()
    }

    @ViewBuilder
    private func buildWeaknewssGridView() -> some View {
        let rows = [
            GridItem(.adaptive(minimum: 100))
        ]

        LazyVGrid(columns: rows, spacing: 10) {
            ForEach(viewModel.pokemonWeakness, id: \.self) { item in
                TypeView(type: item, font: .semiBoldMonoSpaced(12))
            }
        }

    }
}

#Preview {
    PokemonDetailBuilder.build(id: 1)
}
