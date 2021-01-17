//
//  AppDelegate.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    @LazyInject private var appCoordinator: AppCoordinatorInterface

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Assemblies.setup()

        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
}
