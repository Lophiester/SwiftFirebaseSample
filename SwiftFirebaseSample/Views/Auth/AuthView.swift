//
//  AuthView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        VStack{
            NavigationLink {
               SignInWithEmailView()
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .clipShape(.buttonBorder)
            }
         
            .padding()
            Spacer()

        }.navigationTitle("Sign In")
      
    }
}

#Preview {
    NavigationStack{
        AuthView()
    }
}
