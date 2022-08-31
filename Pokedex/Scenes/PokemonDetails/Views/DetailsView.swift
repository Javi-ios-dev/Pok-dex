//
//  DetailsView.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 30/08/22.
//

import UIKit

class DetailsView: UIView {
    
    let detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 22
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.contentInset = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
        
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: DetailsCollectionViewCell.cellId)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let pokeballbg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icons8-pokeball-90")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        //imageView.alpha = 0.1
        return imageView
        
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.173284471, green: 0.173284471, blue: 0.173284471, alpha: 1)
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kakuna"
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            numberLabel,
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        backgroundColor = .white
        addSubview(colorView)
        addSubview(pokeballbg)
        addSubview(stackV)
        
        addSubview(detailsCollectionView)
        NSLayoutConstraint.activate([
            stackV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackV.leftAnchor.constraint(equalTo: leftAnchor, constant: 22),
            stackV.rightAnchor.constraint(equalTo: rightAnchor, constant: -22),
            
            pokeballbg.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            pokeballbg.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            colorView.topAnchor.constraint(equalTo: topAnchor),
            colorView.leftAnchor.constraint(equalTo: leftAnchor),
            colorView.rightAnchor.constraint(equalTo: rightAnchor),
            colorView.bottomAnchor.constraint(equalTo: pokeballbg.bottomAnchor, constant: 42),
            
            
            detailsCollectionView.topAnchor.constraint(equalTo: colorView.bottomAnchor),
            detailsCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            detailsCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            detailsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
        
        pokeballbg.applyShadow()
    }
    
    
    
}


