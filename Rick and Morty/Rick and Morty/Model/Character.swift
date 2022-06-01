//
//  Character.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import Foundation

struct TopLevelDictionary {
    private enum CodingKeys: String, CodingKey {
        case results
    }
    let results: [ResultsDictionary]
}

struct ResultsDictionary {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case image
    }
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: [OriginDictionary]
    let location: [LocationDictionary]
    let image: String
}

struct OriginDictionary {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    let name: String
}

struct LocationDictionary {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    let name: String
}


