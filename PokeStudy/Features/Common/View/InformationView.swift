//
//  InformationView.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 16/06/24.
//

import SwiftUI

struct InformationView: View {
    let image: ImageResource
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 16, height: 16)
                Text(title)
                    .font(.semiBoldMonoSpaced(12))
            }
            Text(text)
                .font(.pokemon(30))
                .padding(.horizontal)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    InformationView(
        image: .darkLogo,
        title: "PESO",
        text: "13.99 kg"
    )
}
