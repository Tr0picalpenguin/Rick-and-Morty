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
    
//    // MARK: - Endpoint 2
//    static func fetchCharacter(with characterURLString: String, completion: @escaping(Result<ResultsDictionary, ResultError>) -> Void) {
//        guard let characterURL = URL(string: characterURLString) else {
//            completion(.failure(.invalidURL(URL(string: characterURLString)!)))
//            return
//        }
//
//        URLSession.shared.dataTask(with: characterURL) { data, _, error  in
//            if let error = error {
//                print("Encountered Error: \(error.localizedDescription)")
//                completion(.failure(.thrownError(error)))
//            }
//            guard let characterData = data else {
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let character = try JSONDecoder().decode(ResultsDictionary.self, from: characterData)
//                completion(.success(character))
//            } catch {
//                print("Encountered error when decoding the data:", error.localizedDescription)
//                completion(.failure(.unableToDecode))
//            }
//        }.resume()
//    }
//
//    // MARK: - Endpoint 3
//    static func fetchOrigin(with originURLString: String, completion: @escaping(Result<OriginDictionary, ResultError>) -> Void) {
//        guard let originURL = URL(string: originURLString) else {
//            completion(.failure(.invalidURL(URL(string: originURLString)!)))
//            return
//        }
//
//        URLSession.shared.dataTask(with: originURL) { data, _, error in
//            if let error = error {
//                print("Encountered Error: \(error.localizedDescription)")
//                completion(.failure(.thrownError(error)))
//            }
//            guard let originData = data else {
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let origin = try JSONDecoder().decode(OriginDictionary.self, from: originData)
//                completion(.success(origin))
//            } catch {
//                print("Encountered error when decoding the data:", error.localizedDescription)
//                completion(.failure(.unableToDecode))
//            }
//        }.resume()
//    }
//
//    // MARK: - Endpoint 4
//    static func fetchLocation(with locationURLString: String, completion: @escaping(Result<LocationDictionary, ResultError>) -> Void) {
//        guard let locationURL = URL(string: locationURLString) else {
//            completion(.failure(.invalidURL(URL(string: locationURLString)!)))
//            return
//        }
//
//        URLSession.shared.dataTask(with: locationURL) { data, _, error in
//            if let error = error {
//                print("Encountered Error: \(error.localizedDescription)")
//                completion(.failure(.thrownError(error)))
//            }
//            guard let locationData = data else {
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let location = try JSONDecoder().decode(LocationDictionary.self, from: locationData)
//                completion(.success(location))
//            } catch {
//                print("Encountered error when decoding the data:", error.localizedDescription)
//                completion(.failure(.unableToDecode))
//            }
//        }.resume()
//    }
    
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
