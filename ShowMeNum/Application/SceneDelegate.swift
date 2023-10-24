//
//  SceneDelegate.swift
//  ShowMeNum
//
//  Created by Aleksey Alyonin on 21.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let windows = UIWindow(windowScene: windowScene)
        let vc = MainViewController()
        let nav = UINavigationController(rootViewController: vc)
        windows.rootViewController = nav
        self.window = windows
        windows.makeKeyAndVisible()
    }
}
