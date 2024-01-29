//
//  UserData.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel: Identifiable, Codable {
    var id : String
    var email : String?
    var photoURL : String?
    var isAnonymous : Bool
    
    init(user : User) {
     id = user.uid
     email = user.email
     photoURL = user.photoURL?.absoluteString
     isAnonymous = user.isAnonymous
    }
}
