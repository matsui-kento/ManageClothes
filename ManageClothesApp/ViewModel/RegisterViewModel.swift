//
//  RegisterViewModel.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/23.
//

import Firebase
import SwiftUI

class RegisterViewModel: ObservableObject {
    
    @Binding var showAlert:Bool
    
    init(showAlert: Binding<Bool>) {
        self._showAlert = showAlert
    }
    
    func registerClothes(category: String, imageString: UIImage) {
        
        guard let imageData = imageString.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (_, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            storageRef.downloadURL { (url, _) in
                guard let imageUrl = url?.absoluteString else { return }
                guard let user = AuthViewModel.shared.userSession else { return }
                let docRef = Firestore.firestore().collection("clothes").document("users").collection(user.uid).document()
                
                let data: [String: Any] = ["category": category,
                                           "image": imageUrl,
                                           "id": docRef.documentID]
                
                docRef.setData(data) { error in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                    self.showAlert = true
                }
            }
        }
    }
}
