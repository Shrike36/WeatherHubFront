//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Nested types

    private enum Constants {
        static let itemsFont: UIFont = .systemFont(ofSize: 10, weight: .medium)
    }

    // MARK: - Properties

    var output: TabBarViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupInitialState()
    }

}

// MARK: - TabBarViewInput

extension TabBarViewController: TabBarViewInput {

    func setupInitialState() {
        configureAppearance()
        configureControllers()
    }

    func selectTab(_ tab: MainTab) {
        guard let view = viewControllers?[tab.rawValue], tabBarController(self, shouldSelect: view) else {
            return
        }
        selectedIndex = tab.rawValue
        tabBarController(self, didSelect: view)
    }

}

private extension TabBarViewController {

    func configureAppearance() {
        let appearance = tabBar.standardAppearance.copy()

        appearance.backgroundColor = Asset.Colors.background.color

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: Constants.itemsFont,
            NSAttributedString.Key.foregroundColor: Asset.Colors.action.color
        ]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: Constants.itemsFont,
            NSAttributedString.Key.foregroundColor: Asset.Colors.tint.color
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = Asset.Colors.action.color
        appearance.stackedLayoutAppearance.selected.iconColor = Asset.Colors.tint.color

        tabBar.standardAppearance = appearance

        tabBar.clipsToBounds = true
    }

    func configureControllers() {
        var childControllers: [UIViewController] = []
        for tab in MainTab.allCases {
            let tabBarItem = UITabBarItem(title: tab.title,
                                          image: tab.image,
                                          selectedImage: tab.image)
            tabBarItem.tag = tab.rawValue
            tabBarItem.imageInsets = .zero

            let navigationController = UINavigationController()
            navigationController.tabBarItem = tabBarItem
            childControllers.append(navigationController)
        }
        viewControllers = childControllers
        selectedIndex = MainTab.weather.rawValue
        tabBarController(self, didSelect: childControllers[selectedIndex])
    }

}

// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view, fromView != toView else {
            return true
        }

        UIView.transition(
            from: fromView,
            to: toView,
            duration: 0.3,
            options: [.transitionCrossDissolve]
        )

        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let tab = MainTab(rawValue: viewController.tabBarItem.tag) else {
            return
        }
        let navigationController = viewController as? UINavigationController
        output?.selectTab(tab, isInitial: navigationController?.viewControllers.isEmpty ?? true)
    }

}
