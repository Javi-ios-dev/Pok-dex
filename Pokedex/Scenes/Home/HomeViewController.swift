//
//  HomeViewController.swift
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

protocol HomeDisplayLogic: AnyObject
{
    func displayPokemons(viewModel: Home.FetchPokemonData.ViewModel)
    func displayPokemonDetails(viewModel: Home.ShowPokemonDetails.ViewModel)
    func displaySearchByTypeSelected(viewModel: Home.SearchByTypeSelected.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var selectedType: String = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    let homeView = HomeView()
    
    var pokemonArray = [PokemonData]()
    var filteredPokemonArray = [PokemonData]()

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View lifecycle
    
    override func loadView() {
        super.loadView()
        view = homeView
        title = "Podédex"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
            self.navigationItem.title="Pokédex"
        
        
        interactor?.searchByTypeSelected(request: Home.SearchByTypeSelected.Request())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonData()
        
        title = "Pokédex"
        
        searchController.searchBar.placeholder = "Busca por nombre o tipo de Pokémon"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: -25, bottom: 0, trailing: 25)
        searchController.searchBar.directionalLayoutMargins = directionalMargins
        
        searchController.searchBar.delegate = self
        
        homeView.pokemonCollectionView.delegate = self
        homeView.pokemonCollectionView.dataSource = self
        
        
    }
    
    //MARK: - receive events from UI
    
    // MARK: - request data from HomeInteractor

    func fetchPokemonData() {
        let request = Home.FetchPokemonData.Request()
        interactor?.fetchPokemons(request: request)
    }
    
    func showPokemonDetails(pokemonData: PokemonData) {
        let request = Home.ShowPokemonDetails.Request(pokemonData: pokemonData)
        interactor?.showPokemonDetails(request: request)
    }

    // MARK: - display view model from HomePresenter
    
    func displaySearchByTypeSelected(viewModel: Home.SearchByTypeSelected.ViewModel) {
        self.filterText(query: viewModel.typeString)
    }
    
    func displayPokemonDetails(viewModel: Home.ShowPokemonDetails.ViewModel) {
        self.router?.routeToDetails()
    }

    func displayPokemons(viewModel: Home.FetchPokemonData.ViewModel) {
        //let myGroup = DispatchGroup()
        
        var pokarray = [PokemonData]()
        viewModel.pokemons.forEach { pokemonEntry in
           // myGroup.enter()
            NetworkManager.shared.getData(with: pokemonEntry.url) { result in
                
                switch result {
                case .success(let pokemonSelected):
                    pokarray.append( PokemonData(pokemonEntry: pokemonEntry, pokemonSelected: pokemonSelected) )
                   
                case .failure(_):
                    print("error sprite")
             
                }
            }
        }
        //myGroup.wait()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.pokemonArray = pokarray
            self.filteredPokemonArray = self.pokemonArray.filter({ $0.pokemonSelected.id < 21 }).sorted{ $0.pokemonSelected.id < $1.pokemonSelected.id }
            self.homeView.pokemonCollectionView.reloadData()
            self.homeView.layoutSubviews()
        }
        
        
        
        
    }
}
