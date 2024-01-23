//
//  AuthManager.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import Foundation
import FirebaseAuth
import Observation

final class AuthManager {
    
    func authanticationManager()throws -> UserData{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return UserData(user: user)
    }
    
    
    func createUser (email: String, password: String) async throws -> UserData {
        do{
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return UserData(user: authDataResult.user)
        }
       
        catch{
            print("Failed to create user with error: \(error.localizedDescription)")
            throw error
        }
    }
    func logOut() throws{
       try Auth.auth().signOut()
    }

}
