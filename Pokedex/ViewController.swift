//
//  ViewController.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var collectionView: UICollectionView!
    var pokeArray: [Pokemon]! = PokemonGenerator.getPokemonArray()
    var segControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        setUpSegControl()
        collectionView.isHidden = true
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
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(PokemonGridCell.self, forCellWithReuseIdentifier: "pokeCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func setUpSegControl(){
        let views = ["List", "Grid"]
        segControl = UISegmentedControl(items: views)
        segControl.selectedSegmentIndex = 0
        segControl.frame = CGRect(x: view.frame.maxX - 150, y: 10, width: 100, height: 30)
        segControl.backgroundColor = UIColor.black
        segControl.addTarget(self, action: #selector(ViewController.changeViews), for: .valueChanged)
        view.addSubview(segControl)
    }
    
    func changeViews(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            tableView.isHidden = false
            collectionView.isHidden = true
        case 1:
            tableView.isHidden = true
            collectionView.isHidden = false
        default:
            tableView.isHidden = false
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! PokemonCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        if let url = NSURL(string: pokeArray[indexPath.row].imageUrl) {
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
        cell.numberLabel.text = String(pokeArray[indexPath.row].number)
        cell.nameLabel.text = pokeArray[indexPath.row].name
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        pokemonToPass = pokeArray[indexPath.row]
//        performSegue(withIdentifier: "segueToFruitVS", sender: self)
//    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonGridCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        cell.nameLabel.text = pokeArray[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pokeCell = cell as! PokemonGridCell
        if let url = NSURL(string: pokeArray[indexPath.row].imageUrl) {
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
    
}
