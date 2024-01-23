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
    func signOut() throws{
       try Auth.auth().signOut()
    }
    func resetPawword(email : String) async throws {
       try await  Auth.auth().sendPasswordReset(withEmail: email)
    }


}
