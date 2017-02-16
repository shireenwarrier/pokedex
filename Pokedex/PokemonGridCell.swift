//
//  PokemonGridCell.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/15/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class PokemonGridCell: UICollectionViewCell {
    var pokeImage: UIImageView!   //Our Poke Image
    var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Our Name Label
        pokeImage = UIImageView(frame: CGRect(x: contentView.frame.width * (1/8), y: contentView.frame.width * (1/8), width: contentView.frame.width * (3/4), height: contentView.frame.width * (3/4)))
        
        nameLabel = UILabel(frame: CGRect(x: pokeImage.frame.minX, y: pokeImage.frame.maxY - 25, width: contentView.frame.width/2, height: 25))
        nameLabel.textColor = UIColor.black
        nameLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(pokeImage)
        contentView.bringSubview(toFront: nameLabel)
    }
    
}
