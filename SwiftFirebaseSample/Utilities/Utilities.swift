//
//  Utilities.swift
//  SwiftFirebaseSample
//
//  Created by Charles Yamamoto on 2024/01/25.
//

import UIKit

final class Utilities {
    static let shared = Utilities()
    
    init(){}
    
    @MainActor
    func getTopViewController(base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? UIWindow.keyWindow?.rootViewController
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
}

extension UIWindow {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
}

