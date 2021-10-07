//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class LocationCoordinator: BaseCoordinator, LocationCoordinatorOutput {

    // MARK: - LocationCoordinatorOutput

    // MARK: - Private Properties

    private let router: Router

    private weak var placesInput: PlacesModuleInput?

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Coordinator

    override func start() {
        super.start()
        showPlaces()
    }

}

// MARK: - Private Methods

private extension LocationCoordinator {

    func showPlaces() {
        let components = PlacesModuleConfigurator().configure()
        placesInput = components.input
        components.output.onAlertNeeded = { [weak self] alert in
            self?.router.present(alert)
        }
        components.output.onSearchNeeded = { [weak self] in
            self?.showSearch()
        }
        components.output.onMapNeeded = { [weak self] in
            self?.showMap()
        }

        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

    func showSearch() {
        let components = PlaceSearchModuleConfigurator().configure()
        router.present(components.view)
    }

    func showMap() {
        let components = MapModuleConfigurator().configure()
        components.output.onLocationSelected = { [weak self] location in
            self?.router.dismissModule(animated: true) {
                self?.placesInput?.handleLocationSelected(location)
            }
        }
        router.present(components.view)
    }

}
