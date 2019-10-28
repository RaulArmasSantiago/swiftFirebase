//
//  MenuTableViewCell.swift
//  Apps con Swift
//
//  Created by Juan Meza on 7/17/19.
//  Copyright © 2019 Juan Meza. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainTableViewCell: UITableViewCell {
    
    var mainTableViewController: MainTableViewController?
    
    var user = User()
    
    var btnTapAction: (()->())?
    
    var post: Post? {
        
        didSet {
            
            fetchUser()
            
            if let post = post?.post {
                
                postLabel.text = post
            }
            
            if let image = post?.image {
                
                postImage.loadImageUsingCacheUsingUrlString(urlString: image)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImage: UIImageView = {
        
        let imageView = UIImageView()
        //imageView.backgroundColor = .blue
        //imageView.image = UIImage(named: "Basico")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.image = UIImage(named: "add-4")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
   
    func fetchUser() {
        
        guard let idUser = post?.idUser else {
                       
            return
        }
        
        
        
        let ref = Database.database().reference().child("users").child(idUser)
        print(ref)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                self.user.name = dictionary["name"] as? String
                self.user.email = dictionary["email"] as? String
                self.user.image = dictionary["image"] as? String

                
            }
            
            self.setupViewInfo(user: self.user)
            
        }, withCancel: nil)
        
    }
    
    func setupViewInfo(user: User) {
        
        if let image = user.image {
            
            profileImageView.loadImageUsingCacheUsingUrlString(urlString: image)
        }
        
        if let name = user.name {
            
            nameLabel.text = name
        }
        
        
        
    }
    
    
    func setupView() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(profileImageView)
        contentView.addSubview(postLabel)
        
        
        
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        
        postImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        postImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        postImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        postImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        postLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 10).isActive = true
        postLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        
        
    }
    
    @objc func subMenu() {
        
        btnTapAction?()
        //..0---print("selecionado")
        //let subMenuTableViewController = SubMenuTableViewController()
        //present(subMenuTableViewController, animated: true, completion: nil)
       // menuTableViewController?.subMenu()
        
    
    }
}
