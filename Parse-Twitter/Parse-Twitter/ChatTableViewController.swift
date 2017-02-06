//
//  ChatTableViewController.swift
//  Parse-Twitter
//
//  Created by Sida Wang on 2/5/17.
//  Copyright © 2017 Santa Clara iOS Connect. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ChatCell: PFTableViewCell {
    var name: String?
    var time: Date?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var likeButton:UIButton!

    var liked: (() -> Void )?
    @IBAction func like(_ sender: UIButton) {
        likeButton.isEnabled = false
        liked?()
    }
}

class ChatTableViewController: PFQueryTableViewController {
    let className = "Posts"

    override func awakeFromNib() {
        super.awakeFromNib()
        parseClassName = className
    }

    @IBAction func post() {
        let sb = UIStoryboard(name: "Post", bundle: nil)
        let postvc = sb.instantiateViewController(withIdentifier: "PostViewController")
        self.present(postvc, animated: true) { 
        }
    }

    @IBAction func logout() {
        PFUser.logOut()
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.appController.didLogout()
        }
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {

        let chatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell

        guard let object = object, let post = object as? Post else {
            print("Asked to make a table view cell for Empty Object")
            return nil
        }

        if let likes = post.likes {
            if likes.contains(PFUser.current()!.objectId!) {
                chatCell.likeButton.isEnabled = false
            } else {
                chatCell.likeButton.isEnabled = true
            }
        }

        chatCell.liked = {

            if var likes = post.likes {
                
                likes.insert(PFUser.current()!.objectId!)
                post["likes"] = Array(likes)
                post.saveInBackground { (success, error) in
                    if (success) {
                        print("like succeed")
                    } else {
                        print("failed")
                    }
                }
            }
        }
        chatCell.label.text = post.message
        return chatCell
    }

}

class Post : PFObject {
    var likes: Set<String>? {
        guard let likesObj = self["likes"],
            let likesString = likesObj as? [String] else {
                return nil
        }
        return Set<String>(likesString)
    }
    var message: String? {
        return self["message"] as? String
    }
}
