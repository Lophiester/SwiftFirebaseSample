//
//  ProfileView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/02/07.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var viewModel = ProfileViewModel()
  
    @Binding var showSignView : Bool
    
    let preferenceOptions:[String] = ["Sports", "Movies", "Books"]
    
    private func preferencceIsSelected(text: String) -> Bool{
        viewModel.user?.preferences?.contains(text) == true
    }
    
    var body: some View {
        List{
            if let user = viewModel.user{
                Text("UserId: \(user.userId)")
                if let isAnonymous = user.isAnonymous{
                    Text("Is Anonymous: \(isAnonymous.description.capitalized)")
                }
                Button {
                viewModel.togglePremiumStatus()
                }label: {
                    Text("User is premium: \((user.isPremium ?? false).description.capitalized)")
                }
                VStack  {
                    HStack{
                        ForEach(preferenceOptions, id: \.self){
                            string in
                            Button(string){
                                if preferencceIsSelected(text: string){
                                    viewModel.removeUserPreference(text: string)
                                } else{
                                    viewModel.addUserPreference(text: string)
                                }
                            }
                            .font(.headline)
                            .buttonStyle(.borderedProminent)
                            .tint(preferencceIsSelected(text: string) ? .green : .red )
                        }
                        
                    
                    }
                }
                Text("User preferences: \((user.preferences ?? []).joined(separator: ", "))").frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .task {
            do{
                try await viewModel.loadCurrentUser()
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .navigationTitle("Profile")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink {
                    SettingView(showSignInView: $showSignView)
                } label: {
                    Image(systemName: "gear")
                        .font(.largeTitle)
                }

            }
        }
    }
}

#Preview {
    NavigationStack{
        ProfileView(showSignView: .constant(false))

    }
}
