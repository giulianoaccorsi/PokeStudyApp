//
//  TypeView.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 15/06/24.
//

import SwiftUI

struct TypeView: View {
    let type: PokemonTypeEntity
    let font: Font

    var body: some View {
        HStack(spacing: 4) {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.white)

                Image(type.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            Text(type.name)
                .foregroundStyle(.text)
                .font(font)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .minimumScaleFactor(0.5)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(type.logo))
        .cornerRadius(24)
    }
}

#Preview {
    VStack(spacing: 16) {
        HStack {
            TypeView(
                type: .init(
                    name: "Bug",
                    logo: "bugLogo"
                ),
                font: .semiBoldMonoSpaced(15)
            )
            TypeView(
                type: .init(
                    name: "Poison",
                    logo: "poisonLogo"
                ),
                font: .semiBoldMonoSpaced(15)
            )
        }
        TypeView(
            type: .init(
                name: "Fire",
                logo: "fireLogo"
            ),
            font: .semiBoldMonoSpaced(15)
        )
    }
    .padding()
}
