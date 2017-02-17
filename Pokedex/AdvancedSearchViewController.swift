//
//  AdvancedSearchViewController.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/16/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class AdvancedSearchViewController: UIViewController {
    
    let typesArray: [String] = ["Water", "Fire", "Grass", "Bug", "Electric", "Ice", "Steel", "Rock", "Fighting", "Ghost", "Psychic", "Dark", "Fairy", "Flying", "Normal", "Poison", "Ground", "Dragon"]
    var savedTypes: [String] = []
    var typesUsed: Bool = false
    var typeTableLabel: UILabel!
    var minDefenseLabel: UILabel!
    var minAttackLabel: UILabel!
    var minHealthLabel: UILabel!
    var minDefenseField: UITextField!
    var minAttackField: UITextField!
    var minHealthField: UITextField!
    var typeTable: UITableView!
    var applyButton: UIButton!
    
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
        typeTableLabel = UILabel(frame: CGRect(x: view.frame.width / 10, y: UIApplication.shared.statusBarFrame.maxY + 20, width: view.frame.width * (4/5), height: 20))
        typeTableLabel.text = "Select all types by which to filter"
        typeTableLabel.adjustsFontForContentSizeCategory = true
        typeTableLabel.textColor = UIColor.black
        typeTableLabel.adjustsFontSizeToFitWidth = true
        
        //Initialize TableView Object here
        typeTable = UITableView(frame: CGRect(x: view.frame.width / 10, y: typeTableLabel.frame.maxY + 10, width: view.frame.width * (4/5), height: view.frame.height/3))
        
        //Register the tableViewCell you are using
        typeTable.register(TypeTableCell.self, forCellReuseIdentifier: "typeTableCell")
        
        //Set properties of TableView
        typeTable.delegate = self
        typeTable.dataSource = self
        typeTable.rowHeight = 50
        typeTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        typeTable.allowsMultipleSelection = true
        
        minDefenseLabel = UILabel(frame: CGRect(x: view.frame.width / 10, y: typeTable.frame.maxY + 20, width: view.frame.width * (2/5), height: 20))
        minDefenseLabel.text = "Enter min Defense:"
        minDefenseLabel.adjustsFontForContentSizeCategory = true
        minDefenseLabel.textColor = UIColor.black
        minDefenseLabel.adjustsFontSizeToFitWidth = true
        
        minDefenseField = UITextField(frame: CGRect(x: view.frame.width * (1/2), y: typeTable.frame.maxY + 20, width: view.frame.width * (2/5), height: 20))
        minDefenseField.textColor = UIColor.black
        minDefenseField.adjustsFontSizeToFitWidth = true
        
        minAttackLabel = UILabel(frame: CGRect(x: view.frame.width / 10, y: minDefenseField.frame.maxY + 20, width: view.frame.width * (2/5), height: 20))
        minAttackLabel.text = "Enter min Attack:"
        minAttackLabel.adjustsFontForContentSizeCategory = true
        minAttackLabel.textColor = UIColor.black
        minAttackLabel.adjustsFontSizeToFitWidth = true
        
        minAttackField = UITextField(frame: CGRect(x: view.frame.width * (1/2), y: minDefenseField.frame.maxY + 20, width: view.frame.width * (2/5), height: 20))
        minAttackField.textColor = UIColor.black
        minAttackField.adjustsFontSizeToFitWidth = true
        
        minHealthLabel = UILabel(frame: CGRect(x: view.frame.width / 10, y: minAttackField.frame.maxY + 20, width: view.frame.width * (2/5), height: 20))
        minHealthLabel.text = "Enter min Health:"
        minHealthLabel.adjustsFontForContentSizeCategory = true
        minHealthLabel.textColor = UIColor.black
        minHealthLabel.adjustsFontSizeToFitWidth = true
        
        minHealthField = UITextField(frame: CGRect(x: view.frame.width * (1/2), y: minAttackField.frame.maxY + 20, width: view.frame.width * (2/5), height: 20))
        minHealthField.textColor = UIColor.black
        minHealthField.adjustsFontSizeToFitWidth = true
        
        applyButton = UIButton(frame: CGRect(x: view.frame.width / 10, y: minHealthField.frame.maxY + 20, width: view.frame.width * (4/5), height: 30))
        applyButton.setTitle("Apply", for: .normal)
        applyButton.setTitleColor(UIColor.black, for: .normal)
        applyButton.addTarget(self, action:#selector(applyFilter), for: .touchUpInside)

        
        //Add tableView to view
        view.addSubview(typeTableLabel)
        view.addSubview(typeTable)
        view.addSubview(minDefenseLabel)
        view.addSubview(minDefenseField)
        view.addSubview(minAttackLabel)
        view.addSubview(minAttackField)
        view.addSubview(minHealthLabel)
        view.addSubview(minHealthField)
        view.addSubview(applyButton)

    }
    
    func applyFilter() {
        performSegue(withIdentifier: "segueToSearch", sender: self)
        print("filter")
    }
    
    func containsType(type: String, arr: [String]) ->Bool {
        for typ in arr {
            if type == typ {
                return true
            }
        }
        return false
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueToSearch" {
//            let profileVC = segue.destination as! SearchViewController
//            profileVC.pokemon = pokemonToPass
//        }
//    }
}

extension AdvancedSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeTableCell") as! TypeTableCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        cell.type.text = typesArray[indexPath.row]
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !containsType(type: typesArray[indexPath.row], arr: savedTypes) {
            savedTypes.append(typesArray[indexPath.row])
            typeTable.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        typeTable.cellForRow(at: indexPath)?.accessoryType = .none
    }

}
