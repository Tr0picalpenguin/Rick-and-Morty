//
//  Character.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    let results: [ResultsDictionary]
}

struct ResultsDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case imageString = "image"
    }
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: OriginDictionary
    let location: LocationDictionary
    let imageString: String?
}

struct OriginDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    let name: String
}

struct LocationDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    let name: String
}


