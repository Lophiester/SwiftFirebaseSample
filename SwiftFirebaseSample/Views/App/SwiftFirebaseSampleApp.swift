//
//  SwiftFirebaseSampleApp.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct SwiftFirebaseSampleApp: App {
    
    init(){
        FirebaseApp.configure()
        print("Firebase start")
        
    }
    
    var body: some Scene {
        WindowGroup {
                RootView()
        }
    }
}
