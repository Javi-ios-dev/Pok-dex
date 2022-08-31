//
//  DetailsViewControllerDelegates.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 30/08/22.
//

import Foundation
import UIKit

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.cellId, for: indexPath) as! DetailsCollectionViewCell
        let stats = router?.dataStore?.pokemonData?.pokemonSelected.stats
        cell.stats = stats
        cell.shinyUrlString = router?.dataStore?.pokemonData?.pokemonSelected.sprites.front_shiny
        let types = router?.dataStore?.pokemonData?.pokemonSelected.types
        cell.pokemonTypes = types
        
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 500)
        
    }
    
}


extension DetailsViewController: DetailsCollectionViewCellDelegate {
    func didTypeButtonPress(typeString: String) {
        backToSearchBy(type: typeString)
        
    }
    
    
}
