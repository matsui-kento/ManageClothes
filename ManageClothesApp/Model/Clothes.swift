//
//  Clothes.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/24.
//


import SwiftUI

struct Clothes: Identifiable {
    
    let id: String
    let category: String
    let image: String
    
    init(dictionary: [String: Any]) {
        
        self.id = dictionary["id"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        
    }
    
}
