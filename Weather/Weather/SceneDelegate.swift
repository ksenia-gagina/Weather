//
//  SceneDelegate.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = scene as? UIWindowScene else { return }
    let window = UIWindow(windowScene: scene)
    let module = MainScreenViewAssembly().createModule()
    let rootViewController = module
    window.rootViewController = UINavigationController(rootViewController: rootViewController)
    window.makeKeyAndVisible()
    self.window = window
  }
}
