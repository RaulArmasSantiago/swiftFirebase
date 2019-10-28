//
//  RegisterViewControllerHandlers.swift
//  ProyectFirbase
//
//  Created by Raul Armas Santiago on 10/11/19.
//  Copyright © 2019 Sento40. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import ProgressHUD

extension RegisterViewController { // El nombre de la extencion es el mismo nombre del componente en mi caso fue ViewController archivo
    
    @objc func backMain() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleRegister() {
        if self.nameNickTextField.text == "" || self.emailTextField.text == "" || self.passwordTextField.text == "" {
            ProgressHUD.showError("Todos los campos son requeridos")
            
        }else{
            print("Entro a guardar datos")
            guard let email = emailTextField.text else { return }
            
            guard let password = passwordTextField.text else { return }
            
            guard let name = nameNickTextField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    return
                }
                
                guard let uid = authResult?.user.uid else { return }
                
                let profileDefault = UIImageView()
                profileDefault.image = UIImage(named: "profile")
                
                let imageName = uid
                
                let storageRef = Storage.storage().reference().child("Profile_Images").child("\(imageName).jpg")
                
                if let profileImage = profileDefault.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1){
                    
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            
                           ProgressHUD.showError(error?.localizedDescription)
                            return
                        }
                        storageRef.downloadURL(completion: {(url, error) in
                            if error != nil {
                                print(error)
                            }
                            
                            let profileImageUrl = url?.absoluteString
                            
                            let values = ["name": name, "email": email, "image":profileImageUrl]
                            self.registerUserIntoDataBase(uid: uid, values: values as [String: AnyObject])
                        })
                        
                    })
                }
                
            })
        }
    }
    
    private func registerUserIntoDataBase(uid: String, values: [String: AnyObject]) {
        
        let userRef = self.ref.child("users").child(uid)
        
        userRef.updateChildValues(values, withCompletionBlock: {(error, ref) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            
            guard let email = self.emailTextField.text, let password = self.passwordTextField.text else {
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (authResult, error) in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    
                    return
                }
                
                let customTambBarController = CustomTabBarController()
                self.present(customTambBarController, animated: true, completion: nil)
            })
        })
    }
}
