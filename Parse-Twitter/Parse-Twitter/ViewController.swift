//
//  ViewController.swift
//  Parse-Twitter
//
//  Created by John Regner on 2/5/17.
//  Copyright © 2017 Santa Clara iOS Connect. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func show(_ sender: Any) {
        let stroyboard = UIStoryboard(name: "ChatTable", bundle: nil)
        let ctvc = stroyboard.instantiateViewController(withIdentifier: "ChatTableViewController") as! ChatTableViewController
        ctvc.parseClassName = "GameScore"
        present(ctvc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

