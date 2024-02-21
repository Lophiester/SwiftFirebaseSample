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
        user = try await UserManager.shared.getUser(userID: authDataResult.id)
    }
}
