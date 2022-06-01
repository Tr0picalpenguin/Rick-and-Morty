//
//  NetworkingController.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import Foundation
import UIKit.UIImage

class NetworkingController {
    
    private static let baseURLString = "https://rickandmortyapi.com/api"
    
    // MARK: - Endpoint 1
    static func fetchTopLevelDictionary(with url: URL, completion: @escaping(Result<TopLevelDictionary, ResultError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                print("Encountered Error: \(error.localizedDescription)")
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let characterDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(characterDictionary))
            } catch {
                completion(.failure(.unabletoDecode))
            }
        }.resume()
    }
    
    // MARK: - Endpoint 2
    
    
}
