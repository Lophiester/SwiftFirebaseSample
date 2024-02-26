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
            let encoder = Firestore.Encoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            try userDocument(userId: user.id).setData(from:user, merge: false, encoder: encoder)}
        catch{
            throw URLError(.badServerResponse)
        }
    }
    
    
    func getUser(userId: String) async throws -> DBUser{
        
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return  try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)}
    
    
    func updateUserPremiumStatus(user: DBUser) async throws{
        let encoder = Firestore.Encoder()
        try  userDocument(userId: user.userId).setData(from: user, merge: true, encoder: encoder)
    }
}

