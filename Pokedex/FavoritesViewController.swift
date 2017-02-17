//
//  FavoritesViewController.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/16/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    static var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = UIColor(red: 0.878, green: 0.890, blue: 0.890, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView(){
        //Initialize TableView Object here
        FavoritesViewController.tableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height))
        
        //Register the tableViewCell you are using
        FavoritesViewController.tableView.register(PokemonCell.self, forCellReuseIdentifier: "pokeCell")
        
        //Set properties of TableView
        FavoritesViewController.tableView.delegate = self
        FavoritesViewController.tableView.dataSource = self
        FavoritesViewController.tableView.rowHeight = 50
        FavoritesViewController.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        
        //Add tableView to view
        view.addSubview(FavoritesViewController.tableView)
    }
    
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchViewController.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! PokemonCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        let poke: Pokemon = SearchViewController.favorites[indexPath.row]
        if let url = NSURL(string: poke.imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                if poke.name.range(of: "Mega ") == nil {
                    cell.pokeImage.contentMode = .scaleAspectFit
                    cell.pokeImage.image = UIImage(data: data as Data)
                } else {
                    cell.pokeImage.contentMode = .scaleAspectFit
                    cell.pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
                }
            } else {
                cell.pokeImage.contentMode = .scaleAspectFit
                cell.pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
            }
        }
        else {
            cell.pokeImage.contentMode = .scaleAspectFit
            cell.pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
        }
        cell.numberLabel.text = String(poke.number)
        cell.nameLabel.text = poke.name
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        cell.numberLabel.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
}

