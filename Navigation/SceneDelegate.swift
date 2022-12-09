//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let winScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: winScene)
        window.rootViewController = createTabBar()
        window.makeKeyAndVisible()
        self.window = window

    }

    func createFeedViewController() -> UINavigationController {
        let nvc = UINavigationController(rootViewController: FeedViewController())
        nvc.tabBarItem = UITabBarItem(title: "Feed news", image: UIImage(systemName: "tv"), tag: 0)
        return nvc
    }

    func createProfileViewController() -> UINavigationController {
//        let nvc = UINavigationController(rootViewController: ProfileViewController())
        let nvc = UINavigationController(rootViewController: LogInViewController())
        nvc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return nvc
    }

    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createFeedViewController(), createProfileViewController()]
//        tabBar.viewControllers = [createProfileViewController(), createFeedViewController()]
        return tabBar
    }
}
