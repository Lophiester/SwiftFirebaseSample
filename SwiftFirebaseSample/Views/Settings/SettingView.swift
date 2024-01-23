//
//  SettingView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import SwiftUI

struct SettingView: View {

    @Binding var showSignInView: Bool
    var viewModel = SettingViewModel()
    
    
    var body: some View {
        List {
            Button(action: {
                Task{
                    do{
                        try  viewModel.signOut()
                        showSignInView = true
                    }catch{
                    print(error)
                    }
                   
                }
            }, label: {
                Text("Logout")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.red)
                    .clipShape(.buttonBorder)}
            ).padding()
            Button(action: {
                Task{
                    do{
                        try await   viewModel.resetPassword()
                        showSignInView = true
                    }catch{
                    print(error)
                    }
                   
                }
            }, label: {
                Text("Reset password")
                    .font(.headline)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .border(Color.red)
            }
            ).padding()
            Spacer()
          
        }.navigationTitle("Setting")
    }
}

#Preview {
    NavigationStack{
        SettingView(showSignInView: .constant(false))
    }
}
