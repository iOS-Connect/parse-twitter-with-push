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
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        guard let chatCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell else {
            return nil
        }
        if let score = object {
            chatCell.label.text = score["playerName"] as? String
        }
        
        return chatCell
    }
    
}

