//
//  DetailsInteractor.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 30/08/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailsBusinessLogic {
    func backToSearchByType(request: Details.BackToSearchByTypeSelected.Request)
}

protocol DetailsDataStore {
    var typeSelected: String { get set }
    var pokemonData: PokemonData? { get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    var typeSelected: String = ""
    
    var pokemonData: PokemonData?
    
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorker?

    // MARK: Do something (and send response to DetailsPresenter)

    func backToSearchByType(request: Details.BackToSearchByTypeSelected.Request) {
        print("from detail\(request.typeString)👹")
        self.typeSelected = request.typeString
        let response = Details.BackToSearchByTypeSelected.Response()
        presenter?.presentBackToSearchByTypeString(response: response)
    }
}