//
//  AddPostViewController.swift
//  RedSocial
//
//  Created by Juan Meza on 10/10/19.
//  Copyright © 2019 Juan Meza. All rights reserved.
//


import Foundation
import UIKit
import ProgressHUD
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   // let ref = Database.database().reference()
    
    
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
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let postTextView: UITextView = {
        let textView = UITextView()
        //textView.placeholder = "Agrega tu post"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Guardar", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setup()
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImage)))
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //fetchUser()
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
        inputContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputContainerView.addSubview(postTextView)
        
        
        
        
        postTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        postTextView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        postTextView.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -12).isActive = true
        postTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
       
        
       
        
        
        
        view.addSubview(saveButton)
        
        saveButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 10).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
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
    
    @objc func handleSave() {
        
        
        
        guard let uid = Auth.auth().currentUser?.uid else {
            
            return
            
        }
        
        guard let post = postTextView.text, let image = imageView.image  else { return }
        
        if(post ==  "" || image == nil) {
            
            
            
            ProgressHUD.showError("Todos los campos se deben de llenar")
            
            
        } else {
            let ref = Database.database().reference().child("posts")
            
            let childRef = ref.childByAutoId()
            
            
            let imageNamePost = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("Post").child("\(imageNamePost).jpg")
            
            if let postImage = imageView.image, let uploadData =  postImage.jpegData(compressionQuality:0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        ProgressHUD.showError(error?.localizedDescription)

                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        if error != nil {
                            print(error)
                        }
                        
                        let postImageUrl = url?.absoluteString
                        
                        let values = ["idUser": uid, "post": post, "image": postImageUrl] as [String: AnyObject]
                        
                        let idPost = childRef.key
                        
                        self.registerPost(idPost: idPost!, values: values as [String: AnyObject])
                        
                    })
                    
                })
            }
        }
        
    }
    
    func registerPost(idPost: String, values: [String: AnyObject]){
        
        let postRef = Database.database().reference().child("posts").child(idPost)
        postRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
            
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            //ProgressHUD.dismiss()
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
   
}


