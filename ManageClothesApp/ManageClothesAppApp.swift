//
//  ManageClothesAppApp.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/22.
//

import SwiftUI
import Firebase

@main
struct ManageClothesAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(authViewModel: AuthViewModel())
            
        }
    }
}
