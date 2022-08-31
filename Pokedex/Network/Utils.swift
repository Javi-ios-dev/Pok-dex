//
//  Utils.swift
//  Pokedex
//
//  Created by Javier Paez Arcos on 29/08/22.
//

import Foundation
import UIKit

struct Utils {
    static let TypeColors:[String:UIColor] = [
        "normal":  #colorLiteral(red: 0.6588235294, green: 0.6549019608, blue: 0.4784313725, alpha: 1),
            "fire": #colorLiteral(red: 0.9333333333, green: 0.5058823529, blue: 0.1882352941, alpha: 1),
            "water":  #colorLiteral(red: 0.3882352941, green: 0.5647058824, blue: 0.9411764706, alpha: 1),
            "electric":  #colorLiteral(red: 0.968627451, green: 0.8156862745, blue: 0.1725490196, alpha: 1),
            "grass":  #colorLiteral(red: 0.4784313725, green: 0.7803921569, blue: 0.2980392157, alpha: 1),
            "ice":  #colorLiteral(red: 0.5882352941, green: 0.8509803922, blue: 0.8392156863, alpha: 1),
            "fighting":  #colorLiteral(red: 0.7607843137, green: 0.1803921569, blue: 0.1568627451, alpha: 1),
            "poison":  #colorLiteral(red: 0.6392156863, green: 0.2431372549, blue: 0.631372549, alpha: 1),
            "ground":  #colorLiteral(red: 0.8862745098, green: 0.7490196078, blue: 0.3960784314, alpha: 1),
            "flying":  #colorLiteral(red: 0.662745098, green: 0.5607843137, blue: 0.9529411765, alpha: 1),
            "psychic":  #colorLiteral(red: 0.9764705882, green: 0.3333333333, blue: 0.5294117647, alpha: 1),
            "bug":  #colorLiteral(red: 0.6509803922, green: 0.7254901961, blue: 0.1019607843, alpha: 1),
            "rock":  #colorLiteral(red: 0.7137254902, green: 0.631372549, blue: 0.2117647059, alpha: 1),
            "ghost":  #colorLiteral(red: 0.4509803922, green: 0.3411764706, blue: 0.5921568627, alpha: 1),
            "dragon":  #colorLiteral(red: 0.4352941176, green: 0.2078431373, blue: 0.9882352941, alpha: 1),
            "dark":  #colorLiteral(red: 0.4392156863, green: 0.3411764706, blue: 0.2745098039, alpha: 1),
            "steel":  #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.8078431373, alpha: 1),
            "fairy":  #colorLiteral(red: 0.8392156863, green: 0.5215686275, blue: 0.6784313725, alpha: 1),
    ]
}


extension UIView {
    func applyShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 0.0
    }
}
