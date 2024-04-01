//
//  ProfileViewModel.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/02/07.
//

import Foundation
import Observation

@Observable
class ProfileViewModel{
    private (set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try  AuthManager.shared.getAuthenticationUser()
        user = try await UserManager.shared.getUser(userId: authDataResult.id)
    }
    
    func togglePremiumStatus(){
        guard let user else {return}
        let currentValue = user.isPremium ?? false
        Task{
            try await  UserManager.shared.updateUserPremiumStatus(userId:user.userId ,isPremium: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    func addUserPreference(text: String) {
        guard let user else {return}
        Task{
            try await  UserManager.shared.addUserPreference(userId: user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    func removeUserPreference(text: String) {
        guard let user else {return}
        Task{
            try await  UserManager.shared.removeUserPreference(userId: user.userId, preference: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}
