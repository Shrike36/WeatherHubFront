//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

final class WeatherPresenter: WeatherModuleOutput {

    // MARK: - Constants

    private enum Constants {
        static let days = 5
        static let locationObserverID = "currentLocation"
    }

    // MARK: - WeatherModuleOutput

    var onAlertNeeded: Closure<UIAlertController>?

    // MARK: - Properties

    weak var view: WeatherViewInput?

    // MARK: - Private properties

    private var dateIndex = 0

    private var place: PlaceEntity!
    private var viewModel: WeatherScreenViewModel!

    private var interactors = WeatherSupplier.allCases.map { WeatherInteractor(service: $0.makeService()) }
    private let storageService = StorageService()
    private let locationManager = LocationManager()
    private let geocoder = CLGeocoder()
    private let savedPlacesService = SavedPlacesService.shared
    private let cacheService = CacheService()

}

// MARK: - WeatherModuleInput

extension WeatherPresenter: WeatherModuleInput {

    func showWeather(for place: PlaceEntity) {
        view?.showLoading()
        self.place = place
        storageService.lastPlace = place
        if let cachedWeather = cacheService.getCache(for: place) {
            viewModel = cachedWeather.weather
            updateView()
        } else {
            interactors.forEach {
                $0.getForecast(for: place.coordinates) { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.updateViewIfResponsesAreReady()
                }
            }
        }
    }

}

// MARK: - WeatherViewOutput

extension WeatherPresenter: WeatherViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func viewWillAppear() {
        view?.setFavoriteState(isSaved: savedPlacesService.isSaved(place: place))
    }

    func layoutFinished() {
        view?.showLoading()
        if let lastPlace = storageService.lastPlace {
            showWeather(for: lastPlace)
        } else {
            getCurrentLocation()
        }
    }

    func prevDateAsked() {
        guard dateIndex > 0 else {
            return
        }
        dateIndex -= 1
        updateDate()
        view?.setDateScrollIndex(dateIndex, animated: true)
    }

    func nextDateAsked() {
        let daysTotal = viewModel.dates.count
        guard dateIndex + 1 < daysTotal else {
            return
        }
        dateIndex += 1
        updateDate()
        view?.setDateScrollIndex(dateIndex, animated: true)
    }

    func scrolledToIndex(_ index: Int) {
        guard index != dateIndex else {
            return
        }
        dateIndex = index
        updateDate()
    }

    func heartSelected(state isSelected: Bool) {
        if isSelected {
            savedPlacesService.add(place: place)
        } else {
            savedPlacesService.remove(place: place)
        }
    }
}

// MARK: - Private methods

private extension WeatherPresenter {

    func updateDate() {
        view?.setDateText(viewModel.dates[dateIndex].date)
        view?.setDateChangeButtonsVisisble(left: dateIndex > 0, right: dateIndex + 1 < viewModel.dates.count)
    }

    func resetResponseReceiveFlags() {
        interactors.forEach { $0.resetState() }
    }

    func updateViewIfResponsesAreReady() {
        if interactors.allSatisfy({ $0.isUpdated }) {
            viewModel = buildViewModel()
            updateView()
            resetResponseReceiveFlags()
            cacheService.save(weather: viewModel, for: place)
        }
    }

    func updateView() {
        view?.configure(with: viewModel)
        view?.setFavoriteState(isSaved: savedPlacesService.isSaved(place: place))
        view?.hideLoading()
    }

    func buildViewModel() -> WeatherScreenViewModel {
        let days = Array(0...Constants.days).map {
            Calendar.current.date(byAdding: .day, value: $0, to: Date())!
        }

        let dates = days.enumerated().map { (index, date) -> DateViewModel in
            return DateViewModel(date: date,
                                 weather: interactors.compactMap { $0.response?.getForecastForDay(index: index) })
        }

        return WeatherScreenViewModel(cityName: place.city, dates: dates)
    }

    func getCurrentLocation() {
        guard let currentLocation = locationManager.currentLocation else {
            handleNoLocation()
            return
        }
        handleLocationDetected(currentLocation.coordinate)
    }

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
            self?.getCurrentLocation()
        }

        locationManager.addLocationObserver(observer: observer)
        locationManager.requestAuthorization()
    }

    func handleLocationDetected(_ location: CLLocationCoordinate2D) {
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude,
                                                   longitude: location.longitude),
                                        preferredLocale: .current) { [weak self] placemarks, _ in
            guard let place = placemarks?.first, let placeModel = PlaceEntity.from(place: place) else {
                // ERROR
                return
            }
            self?.showWeather(for: placeModel)
        }
    }

}
