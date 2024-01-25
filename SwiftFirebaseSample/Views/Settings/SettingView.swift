//
//  SettingView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var showSignInView: Bool
    var viewModel = SettingViewModel()
    
    
    var body: some View {
        List {
            Button("Log out"){
                Task{
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    }
                    catch{print(error)
                    }
                }
            }
            if viewModel.authProviders.contains(.email){
                emailSection
            }
        }
                .onAppear{
                    viewModel.loadAuthProviders()
                }
            
            .navigationTitle("Setting")
        
    }
}

#Preview {
    NavigationStack{
        SettingView(showSignInView: .constant(false))
    }
}

extension SettingView {
    private var emailSection: some View{
        Section {
            Button("Reset password"){
                Task{
                    do {
                        try await viewModel.resetPassword()
                        showSignInView = false
                    }
                    catch{print(error)}
                }
            }
        } header: {
            Text("Email functions")
        }
    }
}
