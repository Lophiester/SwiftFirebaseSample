//
//  SettingViewModel.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import Foundation

 final class SettingViewModel  {
    
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
