//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class WeatherCoordinator: BaseCoordinator, WeatherCoordinatorOutput {

    // MARK: - WeatherCoordinatorOutput

    // MARK: - Private Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Coordinator

    override func start() {
        showWeather()
    }

}

// MARK: - Private Methods

private extension WeatherCoordinator {

    func showWeather() {
        let components = WeatherModuleConfigurator().configure()
        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

}
