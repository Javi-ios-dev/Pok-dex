//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 28/08/22.
//

import Foundation
import UIKit

enum Errors: Error {
    case urlInvalid
    case dataIsNil
    
}

class NetworkManager {
    static let shared = NetworkManager()
    private var baseURL = "https://pokeapi.co/api/v2"
    
    private init() {}
    
    func fetchPokemonData(completionHandler: @escaping(Result<[PokemonEntry], Error>)-> Void) {
        
        let  endPoint = "/pokemon?limit=900"
        
        guard let url = URL(string: baseURL + endPoint) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            DispatchQueue.main.async {
                
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decodedData = try jsonDecoder.decode(Pokemon.self, from: data)
                        completionHandler(.success(decodedData.results))
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getData(with url: String, completionHandler: @escaping(Result<PokemonSelected, Error>)-> Void) {
        
        guard let url = URL(string: url) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            DispatchQueue.main.async {
                
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decodedData = try jsonDecoder.decode(PokemonSelected.self, from: data)
                        completionHandler(.success(decodedData))
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
