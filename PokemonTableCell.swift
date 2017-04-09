//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/15/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    var pokeImage: UIImageView!   //Our Poke Image
    var nameLabel: UILabel!
    var numberLabel: UILabel!
    
    //When do you think this is called?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Our Name Label
        pokeImage = UIImageView(frame: CGRect(x: 20, y: contentView.frame.height * (1/4), width: contentView.frame.height * (3/4), height: contentView.frame.height * (3/4)))
        pokeImage.layer.cornerRadius = pokeImage.frame.size.width/2;
        pokeImage.clipsToBounds = true;
        
        numberLabel = UILabel(frame: CGRect(x: pokeImage.frame.maxX + 15, y: contentView.frame.height * (1/3), width: 40, height: contentView.frame.height * (2/3)))
        numberLabel.textColor = UIColor.black
        numberLabel.adjustsFontSizeToFitWidth = true
        
        nameLabel = UILabel(frame: CGRect(x: numberLabel.frame.maxX + 10, y: contentView.frame.height * (1/3), width: 250, height: contentView.frame.height * (2/3)))
        nameLabel.textColor = UIColor.black
        nameLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(pokeImage)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
