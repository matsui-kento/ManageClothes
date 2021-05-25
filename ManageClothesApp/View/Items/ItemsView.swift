//
//  ItemsView.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/22.
//

import SwiftUI
import Kingfisher

enum Filter: Int, CaseIterable {
    case all
    case tops
    case bottoms
    case other
    
    var title: String {
        switch self {
        case .all: return "全て"
        case .tops: return "トップス"
        case .bottoms: return "ボトムス"
        case .other: return "その他"
        }
    }
}

struct ItemsView: View {
    let image = "https://picsum.photos/300/104"
    private let maxWidth = UIScreen.main.bounds.width
    private let imageSize = (UIScreen.main.bounds.width / 3)
    @State var selectedOption: Filter
    @State var category: String
    @ObservedObject var viewModel = FetchImageViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack() {
                ForEach(Filter.allCases, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                        self.category = option.title
                    }, label: {
                        Text(option.title)
                            .font(.headline)
                            .foregroundColor(self.selectedOption.title == option.title ? .white : .black)
                            .frame(width: maxWidth / CGFloat(Filter.allCases.count + 1), height: 35)
                            .background(Color(self.selectedOption.title == option.title ? .black : .white))
                            .clipShape(Capsule())
                            .padding(.top, 30)
                    })
                }
            }
            .padding(.bottom, 50)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    
                    if category == "全て" {
                        ForEach(viewModel.clothesImages) { clothes in
                            NavigationLink(
                                destination: DetailView(clothes: clothes),
                                label: {
                                    KFImage(URL(string: clothes.image))
                                        .resizable()
                                        .frame(width: imageSize, height: imageSize)
                                        .scaledToFill()
                                        .clipped()
                                })
                        }
                    } else {
                        ForEach(viewModel.filterImages(category: category)) { clothes in
                            NavigationLink(
                                destination: DetailView(clothes: clothes),
                                label: {
                                    KFImage(URL(string: clothes.image))
                                        .resizable()
                                        .frame(width: imageSize, height: imageSize)
                                })
                        }
                    }
                }
            }
            Spacer()
            
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(selectedOption: .all, category: "全て")
    }
}
