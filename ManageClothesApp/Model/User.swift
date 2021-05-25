//
//  User.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/23.
//

import Firebase

struct User: Identifiable {
    
    let id: String
    let username: String
    let email: String
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
    }
}
