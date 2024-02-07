//
//  SettingViewModel.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import Foundation
import Observation
import GoogleSignIn

@Observable
final class SettingViewModel  {
    var authProviders: [AuthProviderOption] = []
    var authUser : AuthDataResultModel? = nil
     
     func loadAuthProviders(){
         if let providers =  try? AuthManager.shared.getProvider() {
             authProviders = providers
         }
     }
    
    func loadAuthUser(){
        authUser = try? AuthManager.shared.authManager()
    }
    
    func signOut () throws{
       try  AuthManager.shared.signOut()
    }
    func deleteAccount() async throws{
        try await AuthManager.shared.deleteAccount()
    }
    
    func resetPassword () async throws {
        let authUser = try AuthManager.shared.authManager()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthManager.shared.resetPawword(email: email)
    }
    func linkGoogleAccount() async throws{
        let viewModel = SignInWithGoogleViewModel()
        let tokkens = try await viewModel.signInGoogleHelper()
        authUser = try await AuthManager.shared.linkGoogleEmail(tokens: tokkens)
 
    }
    
    func linkEmailAccount() async throws {
        let email = "testanonymous@test.com"
        let passsword = "12345678"
        authUser =  try await AuthManager.shared.linkEmail(email: email, password: passsword)
    }
    
}
