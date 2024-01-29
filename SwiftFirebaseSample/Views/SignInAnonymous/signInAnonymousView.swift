//
//  signInAnonymousView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/29.
//

import SwiftUI


struct SignINAnonymous: View {
    
    var viewModel = SignInAnonymousViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        
        Button(action: {
            Task{
                do{
                    try await viewModel.signInAnonymous()
                    showSignInView = false
                    
                }catch{
                    print(error)
                }
            }
            print("sign in  Anonymous")
        }, label: {
            HStack{
                Text("Sign In Anonymous")
                    .font(.headline)
                    .foregroundStyle(.white)
                Image(systemName: "sunglasses.fill")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.gray)
            .clipShape(.buttonBorder)
        })
    }
}

#Preview {
    SignINAnonymous( showSignInView: .constant(false))
}
