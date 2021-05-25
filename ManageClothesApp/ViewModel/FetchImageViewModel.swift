//
//  FetchImageViewModel.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/24.
//

import SwiftUI
import Firebase

class FetchImageViewModel: ObservableObject {
    @Published var clothesImages = [Clothes]()
    @Published var filteredClothes = [Clothes]()
    
    init() {
        fetchImagees()
    }
    
    func fetchImagees() {
        guard let user = AuthViewModel.shared.userSession else { return }
        
        Firestore.firestore().collection("clothes").document("users").collection(user.uid).addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.clothesImages = documents.map({ Clothes(dictionary: $0.data()) })
        }
        
//        Firestore.firestore().collection("clothes").document("users").collection(user.uid).getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            self.clothesImages = documents.map({ Clothes(dictionary: $0.data()) })
//            print(self.clothesImages)
//        }
    }
    
    func filterImages(category: String) -> [Clothes] {
        return clothesImages.filter({ $0.category.hasPrefix(category) })
    }
    
    
    func deleteImage(clothes: Clothes) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let imageRef = Firestore.firestore().collection("clothes").document("users").collection(currentUid)
        
        imageRef.document(clothes.id).delete { _ in
        }
    }
    
}
