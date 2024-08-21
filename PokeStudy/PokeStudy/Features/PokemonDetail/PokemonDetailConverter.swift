import Foundation

protocol PokemonDetailConvertable {
    func convert(_ response: PokemonDetailEntityResponse) -> PokemonDetailEntity
    func convert(_ damageRelations: [String: Int]) -> [PokemonTypeEntity]
}

struct PokemonDetailConverter: PokemonDetailConvertable {

    func convert(_ response: PokemonDetailEntityResponse) -> PokemonDetailEntity {
        let categoryPokemon = extractCategory(from: response)
        let textEntry = extractTextEntry(from: response)

        return PokemonDetailEntity(
            name: response.pokemon.name.capitalized,
            sound: response.pokemon.cries.latest,
            type: convert(response.pokemon.types),
            logo: "\(response.pokemon.types.first?.type.name.rawValue ?? "")Logo",
            background: "\(response.pokemon.types.first?.type.name.rawValue ?? "")",
            image: URL(string: response.pokemon.sprites.frontDefault ?? ""),
            number: response.pokemon.id.formatToPokemonNumber(),
            weight: response.pokemon.weight.formWeightToKilogram(),
            height: response.pokemon.height.formatHeightToMeter(),
            category: categoryPokemon,
            textDescription: textEntry,
            skill: response.pokemon.abilities.first?.ability.name.capitalized ?? ""
        )
    }

    func convert(_ damageRelations: [String: Int]) -> [PokemonTypeEntity] {
        damageRelations
            .filter { $0.value > 1 }
            .map { PokemonTypeEntity(name: $0.key.capitalized, logo: "\($0.key)Logo") }
    }

    private func convert(_ types: [PokemonInfoResponse.SlotTypes]) -> [PokemonTypeEntity] {
        types.map {
            PokemonTypeEntity(
                name: "\($0.type.name.rawValue.capitalized)",
                logo: "\($0.type.name.rawValue)Logo"
            )
        }
    }

    private func extractCategory(from response: PokemonDetailEntityResponse) -> String {
        return response.information.genera
            .first(where: { $0.language.name == "en" })?
            .genus
            .replacingOccurrences(of: "Pokémon", with: "")
            .trimmingCharacters(in: .whitespaces) ?? ""
    }

    private func extractTextEntry(from response: PokemonDetailEntityResponse) -> String {
        guard let flavorTextEntry = response.information.flavorTextEntries
                .first(where: { $0.language.name == "en" }) else {
            return ""
        }

        let rawFlavorText = flavorTextEntry.flavorText
        let cleanedFlavorText = rawFlavorText
            .map { $0 == "\n" || $0 == "\u{000C}" ? " " : String($0) }
            .joined()

        return cleanedFlavorText
    }
}
