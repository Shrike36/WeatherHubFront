//
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

/// Предоставляет методы для обеспечения навигации между экранами
public class MainRouter: Router {

    // MARK: - Private Properties

    private var window: UIWindow? {
        return UIApplication.shared.delegate?.window ?? nil
    }

    private var navigationController: UINavigationController? {
        if let tabBar = UIApplication.shared.sceneKeyWindow?.rootViewController as? UITabBarController {
            return tabBar.selectedViewController as? UINavigationController
        }
        return UIApplication.shared.sceneKeyWindow?.rootViewController as? UINavigationController
    }

    private var topNavigationController: UINavigationController? {
        return topViewController?.navigationController
    }

    private var tabBarController: UITabBarController? {
        return UIApplication.shared.sceneKeyWindow?.rootViewController as? UITabBarController
    }

    private var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }

    // MARK: - Initialization

    public init() {}

    // MARK: - Router

    public func present(_ module: Presentable?) {
        self.present(module, animated: true, completion: nil)
    }

    public func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent() else {
            return
        }
        self.topViewController?.present(controller, animated: animated, completion: completion)
    }

    public func push(_ module: Presentable?) {
        self.push(module, animated: true)
    }

    public func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else {
            return
        }
        topNavigationController?.pushViewController(controller, animated: animated)
    }

    public func push(_ module: Presentable?, animated: Bool, completion: @escaping () -> Void) {
        guard let controller = module?.toPresent() else {
            return
        }
        topNavigationController?.pushViewController(controller, animated: animated, completion: completion)
    }

    public func popModule() {
        self.popModule(animated: true)
    }

    public func popModule(animated: Bool) {
        topNavigationController?.popViewController(animated: animated)
    }

    public func popModule(animated: Bool, completion: @escaping EmptyClosure) {
        topNavigationController?.popViewController(animated: animated, completion: completion)
    }

    public func popPreviousView() {
        guard
            var controllers = topNavigationController?.viewControllers,
            controllers.count >= 3 else {
                return
        }
        controllers.remove(at: controllers.count - 2)
        topNavigationController?.viewControllers = controllers
    }

    public func popToRoot(animated: Bool) {
        topNavigationController?.popToRootViewController(animated: animated)
    }

    public func popToRoot(animated: Bool, completion: @escaping EmptyClosure) {
        topNavigationController?.popToRootViewController(animated: animated, completion: completion)
    }

    public func dismissModule() {
        self.dismissModule(animated: true, completion: nil)
    }

    public func dismissModule(from module: Presentable?) {
        module?.toPresent()?.dismiss(animated: true, completion: nil)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        topViewController?.dismiss(animated: animated, completion: completion)
    }

    public func dismissAll(animated: Bool, completion: (() -> Void)?) {
        guard tabBarController?.presentedViewController != nil else {
            completion?()
            return
        }
        tabBarController?.dismiss(animated: animated, completion: completion)
    }

    public func setNavigationControllerRootModule(_ module: Presentable?,
                                                  animated: Bool = false,
                                                  hideBar: Bool = false) {
        guard let controller = module?.toPresent() else {
            return
        }
        navigationController?.isNavigationBarHidden = hideBar
        navigationController?.setViewControllers([controller], animated: false)
    }

    public func setRootModule(_ module: Presentable?) {
        window?.rootViewController = module?.toPresent()
    }

    public func setTab(_ index: Int) {
        tabBarController?.selectedIndex = index
    }

}
