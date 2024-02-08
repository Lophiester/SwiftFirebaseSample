//
//  SignInWithEmailViewModel.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import Foundation
import Observation

@Observable 
final class SignInWithEmailViewModel {
    var email : String = ""
    var password : String = ""
    
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
       let authDataResult = try await AuthManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
       let _ = try await AuthManager.shared.signIn(email: email, password: password)
    }
   
}
