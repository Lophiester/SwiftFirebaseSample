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
    
    init(auth: AuthDataResultModel) throws {
        self.userId = auth.id
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.photoUrl = auth.photoURL
        self.dateCreated = Date()
    }
}

