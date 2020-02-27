//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Mubarek Mussa on 2/26/20.
//  Copyright © 2020 eventFind. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var username: UITextField!
   
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func signIn(_ sender: Any) {
        let usernameText = username.text
        let passwordText = password.text
        
        PFUser.logInWithUsername(inBackground: usernameText!, password: passwordText!) { (user, error) in
            if(user != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            else{
                  print("Something went wrong logging in \(error?.localizedDescription)")
            }
        }
    }
    @IBAction func signUp(_ sender: Any) {
        var user = PFUser()
        user.username = username.text
        user.password = password.text
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            else{
                print("Something went wrong signing up \(error?.localizedDescription)")
            }
        }
        
    }
}



