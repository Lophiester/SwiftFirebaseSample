//
//  DBUser.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/02/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
}

