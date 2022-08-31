//
//  HomeView.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 27/08/22.
//

import UIKit

class HomeView: UIView {
    
    let pokemonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 22
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.contentInset = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
        
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.cellId)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(pokemonCollectionView)
        NSLayoutConstraint.activate([
            pokemonCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pokemonCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            pokemonCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            pokemonCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
