//
//  SignInWithGoogleViewModel.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/25.
//

import Foundation
import Observation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken : String
    let accessToken: String
    let name: String?
    let email: String?
}


@Observable
final class SignInWithGoogleViewModel{
    
    func signInGoogle() async throws{
        let tokkens = try await signInGoogleHelper()
        let authdataResult = try await  AuthManager.shared.signInWithGoogle(tokens: tokkens)
        try await UserManager.shared.createNewUser(auth: authdataResult)
       
    }
    
    func signInGoogleHelper() async throws -> GoogleSignInResultModel{
        guard let topVC =  await Utilities.shared.getTopViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard  let idToken : String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken : String = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        
        let tokkens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokkens
    }
}
