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
    
    func createNewUser(auth: AuthDataResultModel) async throws{
      let db =  Firestore.firestore()
        var userData:[String: Any] = [
            "user_id" : auth.id,
            "is_anonumous": auth.isAnonymous,
            "date_created": Timestamp()
        ]
        if let email = auth.email{
            userData["email"] = email
        }
        if let photoURL = auth.photoURL{
            userData["photo_url"] = photoURL
        }
        
       try await db.collection("users").document(auth.id).setData(userData, merge: false)
    }
}
