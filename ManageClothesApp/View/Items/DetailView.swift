//
//  DetailView.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/30.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @State var clothes: Clothes
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = FetchImageViewModel()
    
    var body: some View {
        
        VStack {
            KFImage(URL(string: clothes.image))
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .clipped()
            
            Button(action: {
                viewModel.deleteImage(clothes: clothes)
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("アイテムを削除する")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                    .clipShape(Capsule())
                    .padding()
            })
        }
        
    }
}
