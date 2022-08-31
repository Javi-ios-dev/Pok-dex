//
//  HomeViewControllerSearchDelegate.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 27/08/22.
//

import Foundation
import UIKit

extension HomeViewController: UISearchBarDelegate {
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("💬 \(searchText)")
        filterText(query: searchText)
        
    }
    
    func filterText(query: String) {
        print("texto de busqueda \(query) 👻 ")
        filteredPokemonArray.removeAll()
        
        if query == "" {
            filteredPokemonArray = pokemonArray.sorted {
                $0.pokemonSelected.id < $1.pokemonSelected.id
            }
        } else {
            filteredPokemonArray = pokemonArray.filter({
                $0.pokemonEntry.name.contains(query.lowercased())  ||
                $0.pokemonSelected.types[0].type.name.contains(query.lowercased())  ||
                String($0.pokemonSelected.id).contains(query.lowercased())
                
            }).sorted(by: { $0.pokemonSelected.id < $1.pokemonSelected.id })
        }
        
        
        homeView.pokemonCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !filteredPokemonArray.isEmpty {
            return filteredPokemonArray.count
        } else {
            return self.pokemonArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.cellId, for: indexPath) as? PokemonCollectionViewCell
        if !filteredPokemonArray.isEmpty {
            cell?.pokemonData = self.filteredPokemonArray[indexPath.row]
            cell?.nameLabel.text = self.filteredPokemonArray[indexPath.row].pokemonEntry.name.capitalized
        } else {
            cell?.pokemonData = self.pokemonArray[indexPath.row]
            cell?.nameLabel.text = self.pokemonArray[indexPath.row].pokemonEntry.name.capitalized
        }
        
        
        
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeView.pokemonCollectionView.frame.width-32, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !filteredPokemonArray.isEmpty {
            self.showPokemonDetails(pokemonData: filteredPokemonArray[indexPath.row])
        } else {
            self.showPokemonDetails(pokemonData: pokemonArray[indexPath.row])
        }
    }
    
    
}

extension HomeViewController: DetailsViewControllerDelegate {
    func displayTypeString(typeString: String) {
        print("type string from details view in home view \(typeString)")
    }
    
    
}
