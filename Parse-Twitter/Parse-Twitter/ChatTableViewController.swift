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
    var liked: (() -> Void )?
    @IBAction func like(_ sender: UIButton) {
        liked?()
    }
}

class ChatTableViewController: PFQueryTableViewController {
    let className = "Posts"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        parseClassName = className
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
        guard let chatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell else {
            //object["username"]
            
            return nil
        }
        chatCell.liked = {
            //postLike()
            if var likes = object?["likes"] as? [String] {
                likes.append(PFUser.current()!.objectId!)
                object?["likes"] = likes
                object?.saveInBackground { (success, error) in
                    if (success) {
                        print("like succeed")
                    } else {
                        print("failed")
                    }
                }
            }
        }
        if let score = object {
            chatCell.label.text = score["message"] as? String
        }
        return chatCell
    }
    
}

