//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class TabBarPresenter: TabBarModuleOutput {

    // MARK: - TabBarModuleOutput

    var onTabSelected: Closure<MainTab>?

    // MARK: - Properties

    weak var view: TabBarViewInput?

}

// MARK: - TabBarModuleInput

extension TabBarPresenter: TabBarModuleInput {
}

// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {

    func selectTab(_ tab: MainTab) {
        onTabSelected?(tab)
    }

}
