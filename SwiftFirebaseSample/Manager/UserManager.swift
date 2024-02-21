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
    
    func createNewUser(auth: AuthDataResultModel) async throws{
        
        var userData:[String: Any] = [
            "user_id" : auth.id,
            "is_anonymous": auth.isAnonymous,
            "date_created": Timestamp()
        ]
        if let email = auth.email{
            userData["email"] = email
        }
        if let photoURL = auth.photoURL{
            userData["photo_url"] = photoURL
        }
        
        try await userDocument(userId: auth.id).setData(userData, merge: false)
    }
    
    func getUser(userID: String) async throws -> DBUser{
        let snapshot = try await Firestore.firestore().collection("users").document(userID).getDocument()
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
       
        let isAnonymous = data["is_anonymous"] as? Bool
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date
        return  DBUser(userId: userId,isAnonymous: isAnonymous, email: email,photoUrl: photoUrl, dateCreated: dateCreated)
    }
}
