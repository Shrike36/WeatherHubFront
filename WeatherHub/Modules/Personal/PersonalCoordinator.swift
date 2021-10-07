//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class PersonalCoordinator: BaseCoordinator, PersonalCoordinatorOutput {

    // MARK: - PersonalCoordinatorOutput

    // MARK: - Private Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Coordinator

    override func start() {
        showSettings()
    }

}

// MARK: - Private Methods

private extension PersonalCoordinator {

    func showSettings() {
        let components = SettingsModuleConfigurator().configure()
        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

}
