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
    
    
    @IBAction func logout() {
        PFUser.logOut()
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.appController.didLogout()
        }
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        guard let chatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell else {
            return nil
        }
        if let score = object {
            chatCell.label.text = score["message"] as? String
        }
        
        return chatCell
    }
    
}

