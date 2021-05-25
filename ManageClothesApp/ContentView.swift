//
//  ContentView.swift
//  ManageClothesApp
//
//  Created by matsui kento on 2021/04/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        if authViewModel.userSession == nil {
            LoginView(viewModel: authViewModel)
        } else {
            NavigationView {
                
                TabView {
                    ItemsView(selectedOption: .all, category: "全て")
                        .tabItem {
                            Image(systemName: "folder")
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    AddView(viewModel: RegisterViewModel(showAlert: .constant(false)))
                        .tabItem {
                            Image(systemName: "plus.square")
                        }
                    
                    SettingView(viewModel: authViewModel)
                        .tabItem {
                            Image(systemName: "info.circle.fill")
                        }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authViewModel: AuthViewModel())
    }
}

