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
    
    var body: some View {
        List{
            if let user = viewModel.user{
                Text("UserId: \(user.userId)")
                if let isAnonymous = user.isAnonymous{
                    Text("Is Anonymous: \(isAnonymous.description.capitalized)")
                }
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
