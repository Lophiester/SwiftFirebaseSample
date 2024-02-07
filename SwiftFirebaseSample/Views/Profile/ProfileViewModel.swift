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
    private (set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser()  throws {
        user = try  AuthManager.shared.getAuthenticationUser()
    }
}
