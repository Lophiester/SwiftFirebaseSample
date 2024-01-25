//
//  AuthView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    @Binding var showSignInView : Bool
    
    var body: some View {
        VStack{
            NavigationLink {
                SignInWithEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .clipShape(.buttonBorder)
            }
      
            HStack{
                VStack{
                    Divider()
                }
                Text("or")
                VStack{
                    Divider()
                }
            }
            SignInWithGoogleView(showSignInView: $showSignInView)
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    NavigationStack{
        AuthView(showSignInView: .constant(false))
    }
}
