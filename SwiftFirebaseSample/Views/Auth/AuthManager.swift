//
//  AuthManager.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    private init(){}
    
    func authManager()throws -> UserData{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return UserData(user: user)
    }
    func getProvider() throws -> [AuthProviderOption]{
        guard  let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers : [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            }else {
//               fatalError()
//                preconditionFailure()
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
}
enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}

// MARK: SIGN IN WITH EMAIL
extension AuthManager{
    
    func createUser (email: String, password: String) async throws -> UserData {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserData(user: authDataResult.user)
    }
    
    func signIn (email: String, password: String) async throws -> UserData {
        do{
            
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            
            return UserData(user: authDataResult.user)
        }
        
        catch{
            print("Failed to create user with error: \(error.localizedDescription)")
            throw error
        }
    }
    func resetPawword(email : String) async throws {
        try await  Auth.auth().sendPasswordReset(withEmail: email)
    }
}

// MARK: SIGN IN SSO
extension AuthManager{
    @discardableResult
    func signInWithGoogle (tokens: GoogleSignInResultModel) async throws -> UserData {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    func signIn (credential: AuthCredential) async throws -> UserData {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return UserData(user: authDataResult.user)
    }
}


