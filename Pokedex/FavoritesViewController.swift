//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/16/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

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
        let fruitLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: 60))
        fruitLabel.text = "jezanthapus"
        fruitLabel.textColor = UIColor.black
        view.addSubview(fruitLabel)
    }

}
