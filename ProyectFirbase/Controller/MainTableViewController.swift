//
//  MenuTableViewController.swift
//  Apps con Swift
//
//  Created by Juan Meza on 7/17/19.
//  Copyright © 2019 Juan Meza. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MainTableViewController: UITableViewController {
    
    let cellId = "cells"
    var menu = ["Basico", "Intermedio", "Avanzado"]
    var posts = [Post]()
    var levelSent = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Feeds"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addPost))
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPost)
    
        tableView?.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor(displayP3Red: 229, green: 231, blue: 235, alpha: 1)
        
        checkIfUserIsLoggedIn()
        
        //fetchPost()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchPost()
           tableView.reloadData()
          
       }
    
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
            
        } else {
            
            
        }
    }
    
    func fetchPost() {
        
        posts.removeAll()
        
        let ref = Database.database().reference().child("posts")
        
        ref.observe(.childAdded, with: { (snapshot) in
            //print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let post = Post()
                post.idUser = dictionary["idUser"] as? String
                post.post = dictionary["post"] as? String
                post.image = dictionary["image"] as? String
                self.posts.append(post)
            }
            
            /*self.levels.sort(by: {(level1, level2) -> Bool in
                
                return Int(level1.id!.intValue) > Int(level2.id!.intValue)
            })*/
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)
        
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
        
        //print(levels.count)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.post = post
        
        cell.mainTableViewController = self
        
        cell.btnTapAction = {
            () in
            
            //let level = self.levels[indexPath.item]
            //self.levelSent = level.level!
            //print(menu)
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 240
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FeedTableViewCell
        //se usa esto para que se actualice y no desacome los items
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        
        let post = menu[indexPath.row]
        print(post)
        
        //guard let idUserSelected = post.idUser else {
          //  return
        //}
        
        
        
    }
    
    
    
    
    @objc func handleLogout() {
        
        do{
            try Auth.auth().signOut()
            
        } catch let logoutError {
            
            print(logoutError)
        }
        
        let loginViewController = ViewController()
        present(loginViewController, animated: true, completion: nil)
    }
    
    @objc func addPost() {
        
         let addPostViewController = AddPostViewController()
               navigationController?.pushViewController(addPostViewController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
