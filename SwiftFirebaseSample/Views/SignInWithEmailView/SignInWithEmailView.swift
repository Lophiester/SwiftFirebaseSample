//
//  SignInWithEmailView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import SwiftUI

struct SignInWithEmailView: View {
    @State var viewModel = SignInWithEmailViewModel()
    var auth = AuthManager()
    
    var body: some View {
        VStack(spacing: 20){
            TextField(text: $viewModel.email) {
                Text("Email")
            }
            .padding()
            .background(Color.gray.opacity(0.4))
            .clipShape(.buttonBorder)
            .textInputAutocapitalization(.never)
            SecureField(text: $viewModel.password) {
                Text("Password")
            }
            .padding()
            .background(Color.gray.opacity(0.4))
            .clipShape(.buttonBorder)
            .textInputAutocapitalization(.never)
            Button(action: {
                Task{
                    try await auth.createUser(
                        email: viewModel.email,
                        password: viewModel.password)
                }
            }, label: {
                Text("Sign In")
                    .font(.headline)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 55)
                    .foregroundStyle(.white)
                    .background(Color.blue)
                    .clipShape(.buttonBorder)
            })
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In with Email")
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack{
        SignInWithEmailView()
    }
}
