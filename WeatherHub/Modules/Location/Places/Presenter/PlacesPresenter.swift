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

    var onPlaceSelected: Closure<PlaceEntity?>?

    // MARK: - Properties

    weak var view: PlacesViewInput?

    // MARK: - Private Properties

    private let locationManager = LocationManager()
    private let geocoder = CLGeocoder()
    private let placesService = PlacesSynchronizationService()
    private let analyticsService = FirebaseService()

}

// MARK: - PlacesModuleInput

extension PlacesPresenter: PlacesModuleInput {

    func handleLocationSelected(_ location: CLLocationCoordinate2D) {
        view?.showLoading()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude,
                                                   longitude: location.longitude),
                                        preferredLocale: .current) { [weak self] placemarks, _ in
            self?.view?.hideLoading()
            guard let placemark = placemarks?.first else {
                self?.onPlaceSelected?(nil)
                return
            }
            let place = PlaceEntity.from(place: placemark)
            self?.analyticsService.track(event: .placeSelected,
                                         parameters: [FirebaseService.Parameters.placeName: place?.description ?? PlaceEntity.undefined])
            self?.onPlaceSelected?(place)
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
        analyticsService.track(event: .chooseCurrentPlace)
        handleLocationSelected(currentLocation.coordinate)
    }

    func handleSearchNeeded() {
        onSearchNeeded?()
    }

    func handleMapNeeded() {
        onMapNeeded?()
    }

    func handlePlaceSelected(at index: Int) {
        onPlaceSelected?(placesService.savedPlaces[index])
    }

    func handlePlacesAppear() {
        view?.fillPlaces(placesService.savedPlaces.map { PlaceViewModel(title: $0.city, subtitle: $0.country) })
    }

    func removePlace(at index: Int) {
        placesService.remove(at: index)
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
