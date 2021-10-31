//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class TabBarPresenter: TabBarModuleOutput {

    // MARK: - TabBarModuleOutput

    var onTabSelected: Closure<MainTab>?

    // MARK: - Properties

    weak var view: TabBarViewInput?

    // MARK: - Private Properties

    private var currentTab: MainTab = .weather

    private let placesService = PlacesSynchronizationService()

    // MARK: - Internal Methods

    func viewLoaded() {
        placesService.synchronize()
    }

}

// MARK: - TabBarModuleInput

extension TabBarPresenter: TabBarModuleInput {

    func selectTab(_ tab: MainTab) {
        view?.selectTab(tab)
    }

}

// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {

    func selectTab(_ tab: MainTab, isInitial: Bool) {
        guard tab != currentTab, isInitial else {
            return
        }
        onTabSelected?(tab)
        currentTab = tab
    }

}

// MARK: - Private Methods

private extension TabBarPresenter {

    func synchronizeSavedPlaces() {
        placesService.synchronize()
    }

}
