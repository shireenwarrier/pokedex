//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/15/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var pokemon: Pokemon!
    var pokeImage: UIImageView!
    var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        pokeImage = UIImageView(frame: CGRect(x: view.frame.width/5 , y: view.frame.width/5, width: view.frame.width * (3/5), height: view.frame.width * (3/5)))
        if let url = NSURL(string: pokemon.imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                pokeImage.contentMode = .scaleAspectFit
                pokeImage.image = UIImage(data: data as Data)
            } else {
                pokeImage.contentMode = .scaleAspectFit
                pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
            }
        }
        else {
            pokeImage.contentMode = .scaleAspectFit
            pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
        }
        nameLabel = UILabel(frame: CGRect(x: view.frame.width/5 , y: pokeImage.frame.maxY, width: view.frame.width * (3/5), height: view.frame.width * (3/5)))
        nameLabel.text = pokemon.name
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.textColor = UIColor.black
        view.addSubview(pokeImage)
        view.addSubview(nameLabel)
        
    }
    
}
