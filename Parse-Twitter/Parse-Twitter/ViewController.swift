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

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    
    @IBOutlet var loginButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        let pfLoginPage = PFLogInViewController()
        pfLoginPage.delegate = self
        pfLoginPage.signUpController?.delegate = self
        self.present(pfLoginPage, animated: true) { 
            print("pfloginpage presented")
        }
        
        
        
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        
        print("success")
        print(user)
        
        //present homeViewControler Here
        
    }
    
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didFailToSignUpWithError error: Error?) {
        if let er = error {
            print(er.localizedDescription)
        }
        
    }
  
    func log(_ logInController: PFLogInViewController, didFailToLogInWithError error: Error?) {
        
        if let er = error {
            print(er.localizedDescription)
        }
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        
        print(user.email!)
        
        //present homeViewControler Here


        
        
        
    }

}

