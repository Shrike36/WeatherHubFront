//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

final class MapPresenter: MapModuleOutput {

    // MARK: - Constants

    private enum Constants {
        static let locationObserverID = "currentLocation"
    }

    // MARK: - MapModuleOutput

    var onLocationSelected: Closure<CLLocationCoordinate2D>?

    // MARK: - Properties

    weak var view: MapViewInput?

    // MARK: - Private Properties

    private let locationManager = LocationManager()
    private let analyticsService = FirebaseService()

}

// MARK: - MapModuleInput

extension MapPresenter: MapModuleInput {
}

// MARK: - MapViewOutput

extension MapPresenter: MapViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        findCurrentLocation()
        analyticsService.track(event: .mapOpen)
    }

    func handleLocationSelected(_ location: CLLocationCoordinate2D) {
        onLocationSelected?(location)
    }

}

// MARK: - Private Methods

private extension MapPresenter {

    func findCurrentLocation() {
        guard let currentLocation = locationManager.currentLocation else {
            handleNoLocation()
            return
        }
        view?.showLocation(currentLocation)
    }

    func handleNoLocation() {
        guard locationManager.currentAuthStatus == .notDetermined else {
            return
        }
        getSystemLocationPermissions()
    }

    func getSystemLocationPermissions() {
        var observer = LocationObserver(identifier: Constants.locationObserverID)
        observer.authStatusChangeHandler = { [weak self] authStatus in
            guard authStatus == CLAuthorizationStatus.authorizedAlways
                || authStatus == CLAuthorizationStatus.authorizedWhenInUse else {
                    return
            }
            self?.findCurrentLocation()
        }

        locationManager.addLocationObserver(observer: observer)
        locationManager.requestAuthorization()
    }

}
