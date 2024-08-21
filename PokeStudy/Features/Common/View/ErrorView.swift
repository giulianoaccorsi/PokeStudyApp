//
//  ErrorView.swift
//  PokeStudy
//
//  Created by Giuliano Accorsi on 16/06/24.
//

import SwiftUI
import Combine

struct ErrorView: View {
    let retrySubject: PassthroughSubject<Void, Never>

    var body: some View {
        VStack(spacing: 16) {
            Image(.error)

            Text(Strings.errorTitle)
                .multilineTextAlignment(.center)
                .font(.pokemonRBY(20))
                .bold()
            Text(Strings.errorDescription)
                .font(.pokemon(30))

            Spacer()

            Button {
                retrySubject.send()
            } label: {
                Text(Strings.errorPrimaryButton)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.groundLogo)
                    .foregroundColor(.white)
                    .font(.pokemon(30))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView(
        retrySubject: PassthroughSubject<Void, Never>()
    )
}
