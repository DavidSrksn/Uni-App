//
//  NavigationController.swift
//  Uni
//
//  Created by David Sarkisyan on 04.12.2019.
//  Copyright © 2019 DavidS & that's all. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController() 
    }
    
    func setupNavigationController() {
        navigationBar.barTintColor = UIColor.NavigationController.background
        navigationBar.tintColor = UIColor.NavigationController.item
    }

}
