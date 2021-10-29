//
//  Character.swift
//  RickMortyMultiverse
//
//  Created by Pedro Boga on 21/10/21.
//

import Foundation

struct RMCharacters: Decodable {
    let results: [RMCharacter]?
}

struct RMCharacter: Decodable {
    let id: Int?
    let name: String?
    let image: String?
}
