//
//  UserManager.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/02/08.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager{
    static let shared = UserManager()
    
    private init(){}
    private let userCollection =  Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        do{
            try userDocument(userId: user.userId).setData(from:user, merge: false)}
        catch{
            throw URLError(.badServerResponse)
        }
    }
    
    
    func getUser(userId: String) async throws -> DBUser{
        return  try await userDocument(userId: userId).getDocument(as: DBUser.self)}
    
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) async throws{
        let data: [String:Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium]
        try await userDocument(userId: userId).updateData(data)
    }
}

