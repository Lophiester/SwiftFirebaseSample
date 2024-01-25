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
                    SettingView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear{
            let authUser = try? AuthManager.shared.authManager()
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
