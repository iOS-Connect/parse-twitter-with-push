//
//  ViewController.swift
//  Parse-Twitter
//
//  Created by John Regner on 2/5/17.
//  Copyright © 2017 Santa Clara iOS Connect. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController {
    
    
    @IBOutlet var loginButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        let pfLoginPage = PFLogInViewController()
        //pfLoginPage.delegate = self
        self.present(pfLoginPage, animated: true) { 
            print("pfloginpage presented")
        }
        
        
        
    }
  

}

