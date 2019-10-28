//
//  ViewController.swift
//  ProyectFirbase
//
//  Created by Raul Armas Santiago on 10/10/19.
//  Copyright © 2019 Sento40. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "taxiCity")
        image.alpha = 0.2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var textFieldEmail: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Constraseña"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Todavia no estas registrado?"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Da click para hacerlo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        //button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .clear
        view.addSubview(backgroundImage)
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        setupViewContainer()
        setupViewItems()
        setupViewButton()
        
        /*
        textFieldEmail.placeholder = "taxiconectado@domain.com"
        view.addSubview(backgroundImage)
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(textFieldEmail)
        textFieldEmail.backgroundColor = UIColor.white
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        */
        /*
        textFieldEmail.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textFieldEmail.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textFieldEmail.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textFieldEmail.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true*/
        
        
    }
    
    @objc func handleRegister() {
        let registerViewController = RegisterViewController()
        present(registerViewController, animated: true, completion: nil)
    }
    
    func setupViewContainer(){
        view.addSubview(inputContainerView)
        
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupViewItems(){
        inputContainerView.addSubview(textFieldEmail)
        inputContainerView.addSubview(emailSeparatorView)
        inputContainerView.addSubview(textFieldPassword)
        
        textFieldEmail.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        textFieldEmail.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        textFieldEmail.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        textFieldEmail.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailSeparatorView.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: 12).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        textFieldPassword.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor).isActive = true
        textFieldEmail.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        textFieldPassword.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setupViewButton() {
        //view.addSubview(logoImageView)
        view.addSubview(loginButton)
        view.addSubview(registerLabel)
        view.addSubview(registerButton)
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }

}

