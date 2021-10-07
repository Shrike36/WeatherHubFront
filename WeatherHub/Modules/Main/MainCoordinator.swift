//
//  MainCoordinator.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 08.05.2021.
//

final class MainCoordinator: BaseCoordinator {

    private let router: Router = MainRouter()

    override func start() {
        super.start()
        showTabBar()
    }

}

// MARK: - Private Methods

private extension MainCoordinator {

    func showTabBar() {
        let components = TabBarModuleConfigurator().configure()

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
        addDependency(coordinator)
        coordinator.start()
    }

    func runWeatherFlow() {
        let coordinator = WeatherCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }

    func runPersonalFlow() {
        let coordinator = PersonalCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }

}
