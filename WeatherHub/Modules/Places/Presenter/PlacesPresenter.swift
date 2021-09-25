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

    // MARK: - Properties

    weak var view: PlacesViewInput?

    // MARK: - Private Properties

    private let locationManager = LocationManager()

}

// MARK: - PlacesModuleInput

extension PlacesPresenter: PlacesModuleInput {
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
        print(currentLocation.coordinate)
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
