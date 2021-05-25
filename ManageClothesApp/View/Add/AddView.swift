//
//  AddView.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/22.
//

import SwiftUI

enum SelectCategory: Int, CaseIterable {
    case tops
    case bottoms
    case other
    
    var title: String {
        switch self {
        case .tops: return "トップス"
        case .bottoms: return "ボトムス"
        case .other: return "その他"
        }
    }
}

struct AddView: View {
    private let maxWidth = UIScreen.main.bounds.width
    @State var selectedOption: SelectCategory = .tops
    @State var category: String = "トップス"
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    @State private var showImagePicker : Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @ObservedObject var viewModel : RegisterViewModel
    
    var body: some View {
        
        VStack(spacing: 40) {
            
            Button(action: {
                showSheet.toggle()
            }, label: {
                Image(uiImage: (image ?? UIImage(named: "plus"))!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipped()
            })
            .padding(.bottom)
            .actionSheet(isPresented: $showSheet, content: {
                ActionSheet(title: Text("アイテムを追加する"), buttons: [
                    .default(Text("アルバムから選択する")) {
                        showImagePicker.toggle()
                        sourceType = .photoLibrary
                    },
                    .default(Text("カメラで写真を撮る")) {
                        showImagePicker.toggle()
                        sourceType = .camera
                    },
                    .cancel()
                ])
            })
            
            
            VStack(spacing: 15) {
                Text("カテゴリーを選択する")
                    .font(.system(size: 20, weight: .bold))
                
                HStack() {
                    
                    ForEach(SelectCategory.allCases, id: \.self) { option in
                        Button(action: {
                            self.selectedOption = option
                            self.category = option.title
                        }, label: {
                            Text(option.title)
                                .font(.headline)
                                .foregroundColor(self.selectedOption.title == option.title ? .white : .black)
                                .frame(width: maxWidth / CGFloat(SelectCategory.allCases.count + 1), height: 35)
                                .background(Color(self.selectedOption.title == option.title ? .black : .white))
                                .clipShape(Capsule())
                        })
                    }
                    .padding(.vertical, 20)
                }
            }
            
            VStack {
                if image == nil {
                    Text("アイテムを選択してください")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .clipShape(Capsule())
                        .padding()
                } else {
                    Button(action: {
                        showAlert.toggle()
                        viewModel.registerClothes(category: category, imageString: image!)
                        image = nil
                    }, label: {
                        Text("アイテムを登録する")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 340, height: 50)
                            .background(Color(#colorLiteral(red: 0.288436234, green: 0.5958548188, blue: 0.9458127618, alpha: 1)))
                            .clipShape(Capsule())
                            .padding()
                    })
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("アイテムを登録しました！"),
                      message: Text("反映されるまで時間がかかる場合があります。"))
            }
            
            Spacer()
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: sourceType, image: $image, isShown: $showImagePicker)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(viewModel: RegisterViewModel(showAlert: .constant(false)))
    }
}
