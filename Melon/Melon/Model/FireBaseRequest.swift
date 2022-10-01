//
//  FireBaseRequest.swift
//  Melon
//
//  Created by Артем Пашевич on 28.09.22.
//

import UIKit
import Firebase

// MARK: - Request

class Request {

    static var shared: Request = {
            let instance = Request()
        return instance
        }()
    
    private init() {}
        
     func registration(emailTF: UITextField, phoneTF: UITextField, passwordTF: UITextField) {
         Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { result, error in
             if error == nil {
                 if let result = result {
                     let ref = Database.database().reference().child("Users")
                     ref.child(result.user.uid).updateChildValues(["Phone": phoneTF.text!, "Email": emailTF.text!])
                    // go to app
                 } else {
                     passwordTF.text = ""
                     emailTF.text = ""
                 }
             }
         }
    }
    
    func logIn(emailTF: UITextField, passwordTF: UITextField) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { _, error in
                    if error == nil {
                        
                    } else {
                        passwordTF.text = ""
                        emailTF.text = ""
                    }
                }
    }
    
    
}
