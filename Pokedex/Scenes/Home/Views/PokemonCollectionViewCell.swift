//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 27/08/22.
//

import UIKit
import Kingfisher



class PokemonCollectionViewCell: UICollectionViewCell {
    static let cellId = "pokemonCollectionViewCellId"
    
    var pokemonData: PokemonData? {
        didSet {
            guard let url = URL(string: (pokemonData?.pokemonSelected.sprites.front_default)!) else { return }
            self.pokeballbg.kf.setImage(with: url)
            self.backgroundColor = Utils.TypeColors[pokemonData!.pokemonSelected.types[0].type.name]
            self.numberLabel.text = "#\(String(format: "%03d", pokemonData!.pokemonSelected.id))"
            
        }
    }
    
    
    
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.173284471, green: 0.173284471, blue: 0.173284471, alpha: 1)
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kakuna"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            numberLabel,
            nameLabel
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
        backgroundColor = #colorLiteral(red: 0.8530324101, green: 0.8530324101, blue: 0.8530324101, alpha: 1)
        layer.cornerRadius = 18.0
        layer.masksToBounds = true
        
        addSubview(pokeballbg)
        addSubview(stackV)
        
        NSLayoutConstraint.activate([
            
            pokeballbg.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokeballbg.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            
            
            stackV.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            stackV.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            stackV.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
           // stackV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        
        pokeballbg.applyShadow()
    }
}
