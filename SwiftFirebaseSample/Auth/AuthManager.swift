//
//  AuthManager.swift
//  SwiftFirebaseSample
//º
//  Created by Charles Yamamoto on 2024/01/22.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    private init(){}
    
    func authManager()throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
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
    
    func deleteAccount() async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
}
enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}

// MARK: SIGN IN WITH EMAIL
extension AuthManager{
    
    func createUser (email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signIn (email: String, password: String) async throws -> AuthDataResultModel {
        do{
            
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            
            return AuthDataResultModel(user: authDataResult.user)
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
    func signInWithGoogle (tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
// MARK: SIGN IN ANONYMOUS

extension AuthManager {
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel{
       let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func linkEmail (email: String, password: String) async throws -> AuthDataResultModel {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        return try await linkCredential(credential: credential)
    }
    func linkGoogleEmail(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await linkCredential(credential: credential)
        
    }
    private func linkCredential(credential: AuthCredential) async throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        let authDataResult = try await user.link(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}


