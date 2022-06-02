//
//  NetworkingController.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import Foundation
import UIKit.UIImage
import UIKit

class NetworkingController {
    
    static let baseURLString = "https://rickandmortyapi.com/api/character"
    
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
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    // MARK: - Endpoint 2
    static func fetchImage(with imageString: String, completion: @escaping(Result<UIImage, ResultError>) -> Void) {
        guard let imageURL = URL(string: imageString) else {
            completion(.failure(.invalidURL(URL(string: imageString)!)))
            return
        }
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Encountered Error: \(error.localizedDescription)")
                completion(.failure(.thrownError(error)))
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(.unableToDecode))
                return
            }
            completion(.success(image))
        }.resume()
    }
} //END of class
