//
//  LoginViewControllerHandler.swift
//  ProyectFirbase
//
//  Created by Raul Armas Santiago on 10/11/19.
//  Copyright © 2019 Sento40. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import ProgressHUD

extension ViewController { // El nombre de la extencion es el mismo nombre del componente en mi caso fue ViewController archivo
    
    @objc func handleLogin() {
        if self.textFieldEmail.text == "" || self.textFieldPassword.text == "" {
            ProgressHUD.showError("Todos los campos son requeridos")
        } else {
            print("Acceso")
        }
    }
}
