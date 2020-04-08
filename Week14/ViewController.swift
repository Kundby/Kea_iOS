//
//  ViewController.swift
//  Week14_CloudLogin
//
//  Created by admin on 03/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var firebaseManager:FirebaseManager?
    var login:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self)
        firebaseManager?.signOut()
    }

    @IBAction func signUpBtnPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text{
            if email.count > 5 && pwd.count > 5 {
                firebaseManager?.signUp(email: email, pwd: pwd)
            }
        }
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text{
            if email.count > 5 && pwd.count > 5 {
                print("Sign in pressed")
                firebaseManager?.signIn(email: email, pwd: pwd, completion: { (status) -> Bool in
                    if status {
                        print("HI")
                        self.performSegue(withIdentifier: "signInSegue", sender: (Any).self) //If signIn is successfull, then performSegue to which sends user to OverviewController
                    }
                return status})
            }
        }
    }
    
}
