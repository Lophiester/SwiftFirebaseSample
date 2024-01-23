//
//  SettingView.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/23.
//

import SwiftUI

struct SettingView: View {
    
    var auth = AuthManager()
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        VStack {
            Button(action: {
                Task{
                    do{
                      try  auth.logOut()
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
            Spacer()
          
        }.navigationTitle("Setting")
    }
}

#Preview {
    NavigationStack{
        SettingView(showSignInView: .constant(false))
    }
}
