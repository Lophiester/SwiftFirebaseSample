//
//  RootView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import SwiftUI

struct RootView: View {
    @State var showSignInView = false
    
    var body: some View {
        
        ZStack{
            if !showSignInView{
                NavigationStack{
                    ProfileView(showSignView: $showSignInView)
                }
            }
        }
        .onAppear{
            let authUser = try? AuthManager.shared.getAuthenticationUser()
            showSignInView = authUser == nil
   
            }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack{
                AuthView(showSignInView: $showSignInView)
            }
        })
        
        
    }
}


#Preview {
    RootView()
}
