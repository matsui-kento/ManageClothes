//
//  ItemsView.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/22.
//

import SwiftUI
import Kingfisher

struct ItemsView: View {
    let image = "https://picsum.photos/300/104"
    private let imageWidth = (UIScreen.main.bounds.width / 3)
    private let imageHeight = (UIScreen.main.bounds.width / 3)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
            
            ForEach(0..<12) { _ in
                KFImage(URL(string: image))
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
                
            }
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
