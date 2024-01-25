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
    
    var body: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
            Task{
                viewModel.signInGoogle
            }
            print("sign in with google")
        }
    }
}

#Preview {
    SignInWithGoogleView()
}
