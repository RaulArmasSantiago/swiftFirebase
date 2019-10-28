//
//  ProfileViewController.swift
//  Mi Tipo de Cambio
//
//  Created by Juan Meza on 9/6/19.
//  Copyright © 2019 Juan Meza. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let ref = Database.database().reference()
    var user = User()
    
    let inputContainerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.image = UIImage(named: "add-4")
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nombre"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Calle, Numero"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false
        return textField
    }()
    
   
    
    
    
    
    let updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Actualizar", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
        return button
    }()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Profile"
        
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImage)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        setup()
        fetchUser()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //fetchUser()
    }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            
            return
            
        }
        
        print(uid)
        
        let ref = Database.database().reference().child("users").child(uid)
        print(ref)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            //ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                self.user.name = dictionary["name"] as? String
                self.user.email = dictionary["email"] as? String
                self.user.image = dictionary["image"] as? String
                // print(self.user.name)
                
                
            }
            
            self.setupViewInfo(user: self.user)
            //self.fetchImages(uid: self.uidToRef)
            
        }, withCancel: nil)
        
        
    }
    
    func setupViewInfo(user: User) {
        
        if let image = user.image {
            print(image)
            imageView.loadImageUsingCacheUsingUrlString(urlString: image)
        }
        
        if let name = user.name {
             print(name)
            nameTextField.text = name
        }
        
        if let email = user.email {
            print(email)
            emailTextField.text = email
        }
        
       
        
       
        
        
        
    }
    
    func setup() {
        
        view.addSubview(inputContainerView)
        view.addSubview(imageView)
        
        
        
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputContainerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeparatorView)
        inputContainerView.addSubview(emailTextField)
        
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -12).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameSeparatorView.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -12).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -10).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier:  1/2).isActive = true
        
       
        
        
        
        view.addSubview(updateButton)
        
        updateButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 10).isActive = true
        updateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        updateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
    @objc func handleImage(recognizer: UITapGestureRecognizer) {
        
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true , completion: nil)
        
        
    }
    
    @objc func handleUpdate() {
        
        
        
        guard let uid = Auth.auth().currentUser?.uid else {
            
            return
            
        }
        
        guard let name = nameTextField.text, let email = emailTextField.text, let image = imageView.image  else { return }
        
        if(name ==  "" || email == "" || image == nil) {
            
            
            
            ProgressHUD.showError("Todos los campos se deben de llenar")
            
            
        } else {
            
            let imageName = uid
            
            let storageRef = Storage.storage().reference().child("Profile_Images").child("\(imageName).jpg")
            
            if let profileImage = imageView.image, let uploadData =  profileImage.jpegData(compressionQuality:0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        ProgressHUD.showError(error?.localizedDescription)

                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        if error != nil {
                            print(error)
                        }
                        
                        let profileImageUrl = url?.absoluteString
                        
                        let values = ["name": name, "image": profileImageUrl] as [String: AnyObject]
                        
                        let ref = Database.database().reference().child("users").child(uid)
                        
                        ref.updateChildValues(values) { (error, ref) in
                            
                            
                            if error != nil {
                                
                                ProgressHUD.showError(error?.localizedDescription)
                                return
                            }
                            
                            ProgressHUD.showSuccess("La informacion se actualizo con exito")
                            
                            
                            /*
                             let alert = UIAlertController(title: "Actualizacion", message: "El tipo de cambio se actualizo con exito", preferredStyle: .alert)
                             let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                             alert.addAction(OKAction)
                             self.present(alert, animated: true)*/
                        }
                        
                    })
                    
                })
            }
            
            
           
        }
        
    }
    
    @objc func logout() {
        
        do{
            try Auth.auth().signOut()
            
        } catch let logoutError {
            
            print(logoutError)
        }
        
        let loginViewController = ViewController()
        present(loginViewController, animated: true, completion: nil)
    }
    
   
}
