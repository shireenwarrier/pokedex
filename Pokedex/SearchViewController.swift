//
//  SearchViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var tableView: UITableView!
    var collectionView: UICollectionView!
    let pokeArray: [Pokemon]! = PokemonGenerator.getPokemonArray()
    var searchController = UISearchController(searchResultsController: nil)
    var filteredPokemon = [Pokemon]()
    var pokemonToPass: Pokemon!
    var i: Int!

    override func viewDidLoad() {
        i = 0
        super.viewDidLoad()
        filteredPokemon = []
        setupTableView()
        setupCollectionView()
        setupSearchController()
        collectionView.isHidden = true
        self.title = "Search!"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupTableView(){
        //Initialize TableView Object here
        tableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height))
        
        //Register the tableViewCell you are using
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "pokeCell")
        
        //Set properties of TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        
        //Add tableView to view
        view.addSubview(tableView)
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collectionView.register(PokemonGridCell.self, forCellWithReuseIdentifier: "pokeCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func setupSearchController(){
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["List", "Grid"]
        searchController.searchBar.delegate = self
    }
    
    func changeViews(scope: String){
        switch scope {
        case "List":
            tableView.isHidden = false
            collectionView.isHidden = true
        case "Grid":
            tableView.isHidden = true
            collectionView.isHidden = false
        default:
            tableView.isHidden = false
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToProfile" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.pokemon = pokemonToPass
        }
    }

    func filterContentForSearchText(searchText: String, scope: String = "List") {
        let byName = pokeArray.filter {
            pokemon in return (pokemon.name.lowercased().range(of: searchText.lowercased()) != nil)
        }
        let byNumber = pokeArray.filter {
            pokemon in return (String(pokemon.number).range(of: searchText.lowercased()) != nil)
        }
        filteredPokemon = arrayUnion(array1: byName, array2: byNumber)
        changeViews(scope: scope)
        
        tableView.reloadData()
    }
    
    func arrayUnion(array1: [Pokemon], array2: [Pokemon]) ->[Pokemon] {
        var union: [Pokemon] = []
        for poke in array1{
            if !containsMon(mon: poke, arr: array2) {
                union.append(poke)
            }
        }
        for poke in array2{
            if !containsMon(mon: poke, arr: array1) {
                union.append(poke)
            }
        }
        return union
        
    }
    func containsMon(mon: Pokemon, arr: [Pokemon]) ->Bool {
        let name = mon.name
        for poke in arr {
            if name == poke.name {
                return true
            }
        }
        return false
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! PokemonCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        let poke: Pokemon = filteredPokemon[indexPath.row]
        if let url = NSURL(string: poke.imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                cell.pokeImage.contentMode = .scaleAspectFit
                cell.pokeImage.image = UIImage(data: data as Data)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonToPass = filteredPokemon[indexPath.row]
        performSegue(withIdentifier: "segueToProfile", sender: self)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonGridCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        let poke: Pokemon = filteredPokemon[indexPath.row]
        
        cell.nameLabel.text = poke.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var poke: [Pokemon] = filteredPokemon
        
        let pokeCell = cell as! PokemonGridCell
        if let url = NSURL(string: poke[indexPath.row].imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                pokeCell.pokeImage.contentMode = .scaleAspectFit
                pokeCell.pokeImage.image = UIImage(data: data as Data)
            } else {
                pokeCell.pokeImage.contentMode = .scaleAspectFit
                pokeCell.pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
            }
        }
        else {
            pokeCell.pokeImage.contentMode = .scaleAspectFit
            pokeCell.pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokemonToPass = filteredPokemon[indexPath.row]
        performSegue(withIdentifier: "segueToProfile", sender: self)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
        collectionView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
}
