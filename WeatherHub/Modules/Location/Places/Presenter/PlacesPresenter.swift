//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation
import UIKit

final class PlacesPresenter: PlacesModuleOutput {

    // MARK: - Constants

    private enum Constants {
        static let locationObserverID = "currentLocation"
    }

    // MARK: - PlacesModuleOutput

    var onAlertNeeded: Closure<UIAlertController>?
    var onSearchNeeded: EmptyClosure?
    var onMapNeeded: EmptyClosure?

    var onPlaceSelected: Closure<CLPlacemark?>?

    // MARK: - Properties

    weak var view: PlacesViewInput?

    // MARK: - Private Properties

    private let locationManager = LocationManager()
    private let geocoder = CLGeocoder()

}

// MARK: - PlacesModuleInput

extension PlacesPresenter: PlacesModuleInput {

    func handleLocationSelected(_ location: CLLocationCoordinate2D) {
        view?.showLoading()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude,
                                                   longitude: location.longitude),
                                        preferredLocale: .current) { [weak self] placemarks, _ in
            self?.view?.hideLoading()
            self?.onPlaceSelected?(placemarks?.first)
        }
    }

}

// MARK: - PlacesViewOutput

extension PlacesPresenter: PlacesViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func handleLocationRequested() {
        guard let currentLocation = locationManager.currentLocation else {
            handleNoLocation()
            return
        }
        handleLocationSelected(currentLocation.coordinate)
    }

    func handleSearchNeeded() {
        onSearchNeeded?()
    }

    func handleMapNeeded() {
        onMapNeeded?()
    }

}

// MARK: - Private Methods

private extension PlacesPresenter {

    func handleNoLocation() {
        if locationManager.currentAuthStatus == .notDetermined {
            getSystemLocationPermissions()
            return
        }
        onAlertNeeded?(locationManager.getPermissionCustomAlert())
    }

    func getSystemLocationPermissions() {
        var observer = LocationObserver(identifier: Constants.locationObserverID)
        observer.authStatusChangeHandler = { [weak self] authStatus in
            guard authStatus == CLAuthorizationStatus.authorizedAlways
                || authStatus == CLAuthorizationStatus.authorizedWhenInUse else {
                    return
            }
            self?.handleLocationRequested()
        }

        locationManager.addLocationObserver(observer: observer)
        locationManager.requestAuthorization()
    }

}
