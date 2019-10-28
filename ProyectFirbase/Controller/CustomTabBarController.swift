//
//  CustomTabBarController.swift
//  Mi Tipo de Cambio
//
//  Created by Juan Meza on 9/5/19.
//  Copyright © 2019 Juan Meza. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        
        let mainTableViewController = MainTableViewController()
        let firstNavigationController = UINavigationController(rootViewController: mainTableViewController)
        firstNavigationController.title = "Home"
        
       
        
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.title = "Perfil"
        
        viewControllers = [firstNavigationController, profileNavigationController]
        
        tabBar.isTranslucent = false
        
      
    }
}
