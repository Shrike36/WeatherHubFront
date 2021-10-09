//
//  MainCoordinator.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 08.05.2021.
//

final class MainCoordinator: BaseCoordinator {

    // MARK: - Private Properties

    private let router: Router = MainRouter()

    private weak var tabBarInput: TabBarModuleInput?
    private weak var weatherInput: WeatherCoordinatorInput?

    // MARK: - Coordinator

    override func start() {
        super.start()
        showTabBar()
    }

}

// MARK: - Private Methods

private extension MainCoordinator {

    func showTabBar() {
        let components = TabBarModuleConfigurator().configure()
        tabBarInput = components.input

        components.output.onTabSelected = { [weak self] tab in
            switch tab {
            case .location:
                self?.runLocationFlow()
            case .weather:
                self?.runWeatherFlow()
            case .more:
                self?.runPersonalFlow()
            }
        }

        router.setRootModule(components.view)
        runWeatherFlow()
    }

    func runLocationFlow() {
        let coordinator = LocationCoordinator(router: router)
        coordinator.onPlaceSelected = { [weak self] place in
            self?.tabBarInput?.selectTab(.weather)
            self?.weatherInput?.showWeather(for: place)
        }
        addDependency(coordinator)
        coordinator.start()
    }

    func runWeatherFlow() {
        let coordinator = WeatherCoordinator(router: router)
        weatherInput = coordinator
        addDependency(coordinator)
        coordinator.start()
    }

    func runPersonalFlow() {
        let coordinator = PersonalCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }

}
