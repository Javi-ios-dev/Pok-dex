//
//  HomeInteractor.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 26/08/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeBusinessLogic {
    func fetchPokemons(request: Home.FetchPokemonData.Request)
    func showPokemonDetails(request: Home.ShowPokemonDetails.Request)
    func searchByTypeSelected(request: Home.SearchByTypeSelected.Request)
}

protocol HomeDataStore {
    var pokemonData: PokemonData? { get set }
    var typeSelected: String? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    
    var typeSelected: String?
    
    var pokemonData: PokemonData?
    
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""

    // MARK: Do something (and send response to HomePresenter)

    func fetchPokemons(request: Home.FetchPokemonData.Request) {
        worker = HomeWorker()
        worker?.fetchPokemonDataWork(completionHandler: { pokemons in
            let response = Home.FetchPokemonData.Response(pokemons: pokemons)
            self.presenter?.presentPokemons(response: response)
        })
    }
    
    func showPokemonDetails(request: Home.ShowPokemonDetails.Request) {
        self.pokemonData = request.pokemonData
        let response = Home.ShowPokemonDetails.Response()
        self.presenter?.presentPokemonDetails(response: response)
    }
    
    func searchByTypeSelected(request: Home.SearchByTypeSelected.Request) {
        print("selected string \(typeSelected) 🎃")
        guard let typeSelected = typeSelected else {
            return
        }
        print("selected string \(typeSelected) 🎃")
        let response = Home.SearchByTypeSelected.Response(typeString: typeSelected)
        presenter?.presentSearchByTypeSelected(response: response)
    }
}
