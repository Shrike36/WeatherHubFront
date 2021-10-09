//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

final class WeatherCoordinator: BaseCoordinator, WeatherCoordinatorOutput {

    // MARK: - WeatherCoordinatorOutput

    // MARK: - Private Properties

    private let router: Router

    private weak var weatherInput: WeatherModuleInput?

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Coordinator

    override func start() {
        showWeather()
    }

}

// MARK: - WeatherCoordinatorInput

extension WeatherCoordinator: WeatherCoordinatorInput {

    func showWeather(for place: CLPlacemark) {
        weatherInput?.showWeather(for: place)
    }

}

// MARK: - Private Methods

private extension WeatherCoordinator {

    func showWeather() {
        let components = WeatherModuleConfigurator().configure()
        weatherInput = components.input
        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

}
