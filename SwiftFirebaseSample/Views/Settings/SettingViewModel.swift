//
//  SettingViewModel.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import Foundation
import Observation

@Observable
 final class SettingViewModel  {
     var authProviders: [AuthProviderOption] = []
     
     func loadAuthProviders(){
         if let providers =  try? AuthManager.shared.getProvider() {
             authProviders = providers
         }
     }
    
    func signOut () throws{
       try  AuthManager.shared.signOut()
    }
    
    func resetPassword () async throws {
        let authUser = try AuthManager.shared.authManager()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthManager.shared.resetPawword(email: email)
    }
    
}
