//
//  TabBarViewController.swift
//  Pokedex
//
//  Created by Shireen Warrier on 2/16/17.
//  Copyright © 2017 trainingprogram. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupTabBar(){
        let searchViewController = SearchViewController()
        let favoritesViewController = FavoritesViewController()
        
        let searchTabBar = UITabBarItem(title: "Search", image: UIImage(named: "search_icon"), selectedImage: UIImage(named: "search_icon"))
        let favoritesTabBar = UITabBarItem(title: "Favorites", image: UIImage(named: "favorites_icon"), selectedImage: UIImage(named: "favorites_icon"))
        
        searchViewController.tabBarItem = searchTabBar
        favoritesViewController.tabBarItem = favoritesTabBar
        
        self.viewControllers = [searchViewController, favoritesViewController]
    }
    
    
    //Delegate methods
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("hi")
//    }
    
}
