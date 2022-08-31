//
//  DetailsCollectionViewCell.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 30/08/22.
//

import UIKit
import Charts

protocol DetailsCollectionViewCellDelegate {
    func didTypeButtonPress(typeString: String)
}

class DetailsCollectionViewCell: UICollectionViewCell {
    static let cellId = "detailscell"
    
    var delegate: DetailsCollectionViewCellDelegate?
    
    var statsChart: UIStackView = {
        let chart = UIStackView()
        chart.axis = .vertical
        chart.spacing = 12
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    var typeCharts: UIStackView = {
        let chart = UIStackView()
        chart.axis = .horizontal
        chart.spacing = 12
        chart.alignment = .trailing
        chart.distribution = .fillProportionally
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    var shinyUrlString: String? {
        didSet {
            guard let shinyUrlString = shinyUrlString else {
                return
            }
            
            guard let url = URL(string: shinyUrlString) else { return }
            shinyImageView.kf.setImage(with: url)
        }
    }
    
    var pokemonTypes: [TypeElement]? {
        didSet {
            guard let pokemonTypes = pokemonTypes else {
                return
            }
            
            pokemonTypes.forEach { tElement in
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.setTitle(tElement.type.name.uppercased(), for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
                button.backgroundColor = Utils.TypeColors[tElement.type.name]
                button.layer.cornerRadius = 4
                button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
                
                button.addTarget(self, action: #selector(self.buttonpress(button:)), for: .touchUpInside)
                
                typeCharts.addArrangedSubview(button)
            }
            
        }
    }
    
    var stats: [StatElement]? {
        didSet {
            guard let stats = stats else {
                return
            }
            
            
            for (_, item) in stats.enumerated() {
                print(item.stat.name)
                print(item.baseStat)
                print(item.effort)
                
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "\(item.stat.name.uppercased().replacingOccurrences(of: "-", with: " ")):"
                label.font = UIFont.boldSystemFont(ofSize: 16)
                let value = UILabel()
                value.translatesAutoresizingMaskIntoConstraints = false
                value.text = String(item.baseStat)
                
                let horizontalStack = UIStackView(arrangedSubviews: [label, value])
                horizontalStack.translatesAutoresizingMaskIntoConstraints = false
                horizontalStack.axis = .horizontal
                horizontalStack.spacing = 80
                horizontalStack.backgroundColor = #colorLiteral(red: 0.4251369238, green: 0.4251369238, blue: 0.4251369238, alpha: 0.1066911139)
                horizontalStack.layer.cornerRadius = 2
                horizontalStack.distribution = .equalCentering
                horizontalStack.alignment = .trailing
                
                statsChart.addArrangedSubview(horizontalStack)
            }
        }
    }
    
    let shinyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SHINY"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let shinyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icons8-pokeball-90")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        //imageView.alpha = 0.1
        return imageView
        
    }()
    
    lazy var shinyStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            shinyLabel, shinyImageView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    
    
    @objc func buttonpress(button: UIButton) {
        print(button.titleLabel?.text)
        if let typeString = button.titleLabel?.text {
            delegate?.didTypeButtonPress(typeString: typeString.lowercased())
        }
        
    }
    
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponent() {
        addSubview(typeCharts)
        addSubview(statsChart)
        addSubview(shinyStack)
        NSLayoutConstraint.activate([
            
            typeCharts.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            typeCharts.leftAnchor.constraint(equalTo: leftAnchor, constant: 22),
            //typeCharts.heightAnchor.constraint(equalToConstant: 42),
            
            statsChart.topAnchor.constraint(equalTo: typeCharts.bottomAnchor, constant: 22),
            statsChart.leftAnchor.constraint(equalTo: leftAnchor, constant: 22),
            statsChart.rightAnchor.constraint(equalTo: rightAnchor, constant: -22),
            
            shinyStack.topAnchor.constraint(equalTo: statsChart.bottomAnchor, constant: 42),
            shinyStack.leftAnchor.constraint(equalTo: statsChart.leftAnchor),
            
        ])
    }
    
}
