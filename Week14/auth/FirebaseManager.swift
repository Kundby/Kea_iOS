//
//  FirebaseManager.swift
//  Week14_CloudLogin
//
//  Created by admin on 03/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager{
    
    var auth = Auth.auth() //Firebase Auth
    var status:Bool?
    let parentVC:UIViewController
    
    init(parentVC:UIViewController) {
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                print("User is logged in") //Shows otherwise hidden content
                
            }else{
                print("User is logged out") // Shows login screen
            }
        }
    }
    
    func signUp(email:String, pwd:String){
        auth.createUser(withEmail: email, password: pwd) { (result, error) in
            if (error == nil){
                print("Sign up success")
            }else{
                print("Sign up failed")
            }
        }
    }
    
    func signIn(email:String, pwd:String, completion: @escaping (Bool) -> Bool){
        auth.signIn(withEmail: email, password: pwd) { (result, error) in
            if (error == nil){
                print("Sign in success")
                self.status = true
            }else{
                print("Sign in failed")
                self.status = false
            }
            completion (self.status!)}
    }
    
    func signOut(){
        do{
            try auth.signOut()
        }catch let error{
            print(error)
        }
    }
}
