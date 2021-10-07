//
//  AppDelegate.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 06.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var mainCoordinator = MainCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeRootView()
        runAppFlow()
        return true
    }

}

private extension AppDelegate {

    func initializeRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }

    func runAppFlow() {
        mainCoordinator.start()
    }
}
