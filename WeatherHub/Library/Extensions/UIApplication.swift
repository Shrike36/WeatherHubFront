//
//  UIApplication.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.05.2021.
//

import UIKit

public extension UIApplication {

    static func topViewController(_ controller: UIViewController?
                                    = UIApplication.shared.sceneKeyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }
        return controller
    }

    static func appVersion() -> String? {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return appVersion
    }

    static var statusBarHeight: CGFloat {
        return UIApplication.shared.sceneKeyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }

    var sceneKeyWindow: UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }

}
