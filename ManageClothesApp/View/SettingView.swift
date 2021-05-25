//
//  SettingView.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/30.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 50) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("アプリ情報")
                Divider()
                HStack {
                    Text("バージョン")
                    Spacer()
                    Text("1.0.0")
                }
                Divider()
                Button(action: {
                    
                }, label: {
                    Text("ライセンス")
                })
                Divider()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("その他")
                Divider()
                
                Button(action: {
                    
                }, label: {
                    Text("レビューする")
                })
                Divider()
                
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("ログアウト")
                })
                Divider()
            }
            
            Spacer()
        }
        .padding()
        .foregroundColor(.black)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: AuthViewModel())
    }
}
