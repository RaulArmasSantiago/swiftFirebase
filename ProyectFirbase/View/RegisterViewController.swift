//
//  RegisterViewController.swift
//  ProyectFirbase
//
//  Created by Raul Armas Santiago on 10/11/19.
//  Copyright © 2019 Sento40. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
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
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Registrar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let nameNickTextField: UITextField = {
        let textFiel = UITextField()
        textFiel.placeholder = "Nombre/Usuario"
        textFiel.translatesAutoresizingMaskIntoConstraints = false
        return textFiel
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let textFiel = UITextField()
        textFiel.placeholder = "Email"
        textFiel.autocapitalizationType = .none
        textFiel.translatesAutoresizingMaskIntoConstraints = false
        return textFiel
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textFiel = UITextField()
        textFiel.placeholder = "Password"
        textFiel.autocapitalizationType = .none
        textFiel.translatesAutoresizingMaskIntoConstraints = false
        return textFiel
    }()
    
    let agreeRegisterLabel: UILabel = {
        let label = UILabel()
        label.text = "Presionando Registrar usted acepta"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsOfServiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terminos y condiciones &", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    let privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Aviso de privacidad", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("X", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backMain), for: .touchUpInside)
        return button
    }()
    
    let ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupViewContainer()
        setupItem()
        setupViewButton()

        // Do any additional setup after loading the view.
    }
    
    func setupViewContainer() {
        view.addSubview(inputContainerView)
        
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupItem() {
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(nameNickTextField)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(emailSeparatorView)
        inputContainerView.addSubview(nameSeparatorView)
        
        nameNickTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameNickTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameNickTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameNickTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameNickTextField.bottomAnchor).isActive = true
        nameSeparatorView.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -12).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameNickTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -12).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    }
    
    func setupViewButton() {
        view.addSubview(registerButton)
        view.addSubview(agreeRegisterLabel)
        view.addSubview(termsOfServiceButton)
        view.addSubview(privacyPolicyButton)
        view.addSubview(cancelButton)
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        agreeRegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agreeRegisterLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 25).isActive = true
        agreeRegisterLabel.widthAnchor.constraint(equalTo: registerButton.widthAnchor).isActive = true
        
        let width = view.frame.width / 7.0
        
        termsOfServiceButton.topAnchor.constraint(equalTo: agreeRegisterLabel.bottomAnchor, constant: 4).isActive = true
        termsOfServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: width).isActive = true
        
        privacyPolicyButton.topAnchor.constraint(equalTo: agreeRegisterLabel.bottomAnchor, constant: 4).isActive = true
        privacyPolicyButton.leftAnchor.constraint(equalTo: termsOfServiceButton.rightAnchor, constant: 2).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
