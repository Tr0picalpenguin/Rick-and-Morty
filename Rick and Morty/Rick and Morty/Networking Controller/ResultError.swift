//
//  ResultError.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import Foundation

enum ResultError: LocalizedError {
    case noData
    case unabletoDecode
    case invalidURL(URL)
    case thrownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "The server responded with no data. Try again."
        case .unabletoDecode:
            return "Unable to decode the object. Check the data from your endpoint."
        case .invalidURL(let url):
            return "Unable to reach the server. Check the url \(url)"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        }
    }
}
