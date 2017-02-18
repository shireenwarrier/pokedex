//
//  SearchViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    static var tableView: UITableView!
    var collectionView: UICollectionView!
    static let pokeArray: [Pokemon]! = PokemonGenerator.getPokemonArray()
    var searchController = UISearchController(searchResultsController: nil)
    static var filteredPokemon: [Pokemon] = []
    var pokemonToPass: Pokemon!
    var randomButton: UIBarButtonItem!
    var randomBool: Bool = false
    static var typesArray: [String]!
    static var minHP: Int!
    static var minDef: Int!
    static var minAtt: Int!
    static var favorites: [Pokemon]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        setupSearchController()
        setupNavBar()
        collectionView.isHidden = true
        SearchViewController.typesArray = []
        SearchViewController.favorites = []
        SearchViewController.minHP = 0
        SearchViewController.minAtt = 0
        SearchViewController.minDef = 0
        view.backgroundColor = UIColor(red: 0.878, green: 0.890, blue: 0.890, alpha: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        self.title = "PokéDex"
        randomButton = UIBarButtonItem(title: "Surprise Me", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.surpriseMe))
        navigationItem.rightBarButtonItem = randomButton
        
    }
    
    func surpriseMe() {
        SearchViewController.filteredPokemon = []
        var j = Int(arc4random_uniform(UInt32(SearchViewController.pokeArray.count)))
        for _ in (0..<20) {
            while containsMon(mon: SearchViewController.pokeArray[j], arr: SearchViewController.filteredPokemon) {
                j = Int(arc4random_uniform(UInt32(SearchViewController.pokeArray.count)))
            }
            SearchViewController.filteredPokemon.append(SearchViewController.pokeArray[j])
        }
        randomBool = true
        SearchViewController.tableView.reloadData()
        collectionView.reloadData()
        
    }
    
    func setupTableView(){
        //Initialize TableView Object here
        SearchViewController.tableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height))
        
        //Register the tableViewCell you are using
        SearchViewController.tableView.register(PokemonCell.self, forCellReuseIdentifier: "pokeCell")
        
        //Set properties of TableView
        SearchViewController.tableView.delegate = self
        SearchViewController.tableView.dataSource = self
        SearchViewController.tableView.rowHeight = 50
        SearchViewController.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 50/2, right: 0)
        
        //Add tableView to view
        view.addSubview(SearchViewController.tableView)
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
        SearchViewController.tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["List", "Grid"]
        searchController.searchBar.delegate = self
    }
    
    func changeViews(scope: String){
        switch scope {
        case "List":
            SearchViewController.tableView.isHidden = false
            collectionView.isHidden = true
            SearchViewController.tableView.reloadData()
            searchController.searchBar.showsCancelButton = true
            
        case "Grid":
            SearchViewController.tableView.isHidden = true
            collectionView.isHidden = false
            searchController.searchBar.showsCancelButton = false
            
        default:
            SearchViewController.tableView.isHidden = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToProfile" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.pokemon = pokemonToPass
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "List") {
        if !randomBool || (randomBool && searchText != "") {
            let byName = SearchViewController.pokeArray.filter {
                pokemon in return (pokemon.name.lowercased().range(of: searchText.lowercased()) != nil)
            }
            let byNumber = SearchViewController.pokeArray.filter {
                pokemon in return (String(pokemon.number).range(of: searchText.lowercased()) != nil)
            }
            SearchViewController.filteredPokemon = arrayUnion(array1: byName, array2: byNumber)
            changeViews(scope: scope)
            randomBool = false
            SearchViewController.tableView.reloadData()
        }
        changeViews(scope: scope)
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
        return SearchViewController.filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! PokemonCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        let poke: Pokemon = SearchViewController.filteredPokemon[indexPath.row]
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
        } else {
            cell.pokeImage.contentMode = .scaleAspectFit
            cell.pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
        }
        cell.numberLabel.text = String(poke.number)
        cell.nameLabel.text = poke.name
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        cell.numberLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonToPass = SearchViewController.filteredPokemon[indexPath.row]
        performSegue(withIdentifier: "segueToProfile", sender: self)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchViewController.filteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonGridCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        let poke: Pokemon = SearchViewController.filteredPokemon[indexPath.row]
        
        cell.nameLabel.text = poke.name
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var poke: [Pokemon] = SearchViewController.filteredPokemon
        
        let pokeCell = cell as! PokemonGridCell
        if let url = NSURL(string: poke[indexPath.row].imageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                if poke[indexPath.row].name.range(of: "Mega ") == nil {
                    pokeCell.pokeImage.contentMode = .scaleAspectFit
                    pokeCell.pokeImage.image = UIImage(data: data as Data)
                } else {
                    pokeCell.pokeImage.contentMode = .scaleAspectFit
                    pokeCell.pokeImage.image = #imageLiteral(resourceName: "missing_pokemon")
                }
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
        pokemonToPass = SearchViewController.filteredPokemon[indexPath.row]
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
