//
//  Coordinator.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 08.05.2021.
//

final class Coordinator {

    private let router: Router = MainRouter()

    func showTabBar() {
        let components = TabBarModuleConfigurator().configure()

        components.output.onTabSelected = { [weak self] tab in
            switch tab {
            case .location:
                self?.showPlaces()
            case .weather:
                self?.showWeather()
            case .more:
                self?.showSettings()
            }
        }

        router.setRootModule(components.view)
        showWeather()
    }

    func showPlaces() {
        let components = PlacesModuleConfigurator().configure()
        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

    func showWeather() {
        let components = WeatherModuleConfigurator().configure()
        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

    func showSettings() {
        let components = SettingsModuleConfigurator().configure()
        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

}
