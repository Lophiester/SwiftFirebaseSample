//
//  SignInWithGoogleView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInWithGoogleView: View {
    
    var viewModel = SignInWithGoogleViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
            Task{
                do{
                    try await viewModel.signInGoogle()
                    showSignInView = false
                    
                }catch{
                    print(error)
                }
            }
            print("sign in with google")
        }
    }
}

#Preview {
    SignInWithGoogleView( showSignInView: .constant(false))
}
