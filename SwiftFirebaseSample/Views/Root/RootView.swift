//
//  RootView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import SwiftUI

struct RootView: View {
    var auth = AuthManager()
    @State var showSignInView = false
    
    var body: some View {
        
        ZStack{
            NavigationStack{
                SettingView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser = try? auth.authanticationManager()
            showSignInView = authUser == nil
            }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack{
                AuthView()
            }
        })
        
        
    }
}


#Preview {
    RootView()
}
