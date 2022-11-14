//
//  User.swift
//  Melon
//
//  Created by Артем Пашевич on 2.10.22.
//

import Foundation
import Firebase

class User {
    
    let uid: String
    let email: String
    let phone: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email ?? ""
        self.phone = user.phoneNumber ?? ""
    }
}
