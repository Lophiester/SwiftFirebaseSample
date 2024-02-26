//
//  DBUser.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/02/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Identifiable, Codable {
    var id : String{
        return userId
    }
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let isPremium: Bool?
    
    init(auth: AuthDataResultModel) throws {
        self.userId = auth.id
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.photoUrl = auth.photoURL
        self.dateCreated = Date()
        self.isPremium = false
    }
    
    init( userId: String,
          isAnonymous: Bool? = nil,
          email: String? = nil,
          photoUrl: String? = nil,
          dateCreated: Date? = nil,
          isPremium: Bool? = nil)
    {
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium    }
}

