//
//  File.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 28/08/22.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [PokemonEntry]
}

struct PokemonData {
    let pokemonEntry: PokemonEntry
    let pokemonSelected: PokemonSelected
}

// MARK: - Result
struct PokemonEntry: Codable {
    var name: String
    let url: String
}

struct PokemonSelected: Codable {
    var sprites: PokemonSprites
    let types: [TypeElement]
    let stats: [StatElement]
    let id: Int
}


// MARK: - StatElement
struct StatElement: Codable {
    let baseStat, effort: Int
    let stat: StatStat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - StatStat
struct StatStat: Codable {
    let name: String
    let url: String
}


struct PokemonSprites: Codable {
    var front_default: String
    var front_shiny: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypeType
}

// MARK: - TypeType
struct TypeType: Codable {
    let name: String
    let url: String
}



// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
