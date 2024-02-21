//
//  SignInAnonymousViewModel.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/29.
//

import Foundation
import Observation

@Observable
final class SignInAnonymousViewModel {
    
    func signInAnonymous() async throws{
     let authDataResult =   try await AuthManager.shared.signInAnonymous()
        let user = try DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}
