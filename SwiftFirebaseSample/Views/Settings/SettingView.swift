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
            Button(role: .destructive) {
                Task{
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    }
                    catch{print(error)
                    }
                }
            } label: {
                Text("Delete Account")
            }

            if viewModel.authProviders.contains(.email){
                emailSection
            }
            if viewModel.authUser?.isAnonymous == true{
                anonymousSection
            }
        }
        .onAppear{
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
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

extension SettingView {
    private var anonymousSection: some View{
        Section {
            Button("Link Google Account"){
                Task{
                    do {
                        try await viewModel.linkGoogleAccount()
                        print("GOOGLE LINKED")
                        showSignInView = false
                    }
                    catch{print(error)}
                }
            }
            Button("Link Email Account"){
                Task{
                    do {
                        try await viewModel.linkEmailAccount()
                        print("EMAIL LINKED")
                        showSignInView = false
                    }
                    catch{print(error)}
                }
            }
        } header: {
            Text("Create account")
        }
    }
}
