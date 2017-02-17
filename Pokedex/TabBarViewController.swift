//
//  TabBarViewController.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/16/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    static var favoritesArray: [Pokemon] = []
    
    struct defaultsKeys {
        static let favoritesArray = "FavoritesArray"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate = self
//        FavoritesViewController.tableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.maxY, width: view.frame.width, height: view.frame.height))
        storeValue()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func setupTabBar(){
//        print("DONE")
//        let searchViewController = SearchViewController()
//        let favoritesViewController = FavoritesViewController()
//        let advancedSearchViewController = AdvancedSearchViewController()
//        
//        let searchTabBar = UITabBarItem(title: "Search", image: UIImage(named: "search_icon"), selectedImage: UIImage(named: "search_icon"))
//        let favoritesTabBar = UITabBarItem(title: "Favorites", image: UIImage(named: "favorites_icon"), selectedImage: UIImage(named: "favorites_icon"))
//        let advancedSearchTabBar = UITabBarItem(title: "Advanced Search", image: UIImage(named: "favorites_icon"), selectedImage: UIImage(named: "favorites_icon"))
//        
//        searchViewController.tabBarItem = searchTabBar
//        favoritesViewController.tabBarItem = favoritesTabBar
//        advancedSearchViewController.tabBarItem = advancedSearchTabBar
//        
//        self.viewControllers = [searchViewController, favoritesViewController, advancedSearchViewController]
//    }
//    
    func storeValue() {
        let defaults = UserDefaults.standard
        
        defaults.setValue(TabBarViewController.favoritesArray, forKey: TabBarViewController.defaultsKeys.favoritesArray)
        
        defaults.synchronize()
    }
    
}
