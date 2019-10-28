//
//  LoginViewControllerHandlers.swift
//  Apps con Swift
//
//  Created by Juan Meza on 7/26/19.
//  Copyright © 2019 Juan Meza. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import ProgressHUD
import FirebaseAuth


extension ViewController {
    
    @objc func handleLogin() {
        
        if self.textFieldEmail.text == "" || self.textFieldPassword.text == "" {
            
            ProgressHUD.showError("Todos los campos son requeridos")
           
        } else {
            
            guard let email = textFieldEmail.text, let password = textFieldPassword.text else {
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    return
                }
                
                let customTabBarController = CustomTabBarController()
                self.present(customTabBarController, animated:  true, completion: nil)
            }
        }
    }
    
    @objc func handleForgotPassword() {
        print("password")
    }
}
