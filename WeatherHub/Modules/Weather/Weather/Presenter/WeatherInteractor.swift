//
//  WeatherInteractor.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import CoreLocation

class WeatherInteractor {

    // MARK: - Properties

    private(set) var response: ForecastProvider?
    private(set) var isUpdated = false

    // MARK: - Private Properties

    private let service: WeatherService

    // MARK: - Initialization

    init(service: WeatherService) {
        self.service = service
    }

    // MARK: - Internal Methods

    func getForecast(for coordinates: CLLocationCoordinate2D,
                     completion: @escaping EmptyClosure) {
        service.getForecast(for: coordinates) { [weak self] response in
            self?.response = response
        } deferred: { [weak self] in
            self?.isUpdated = true
            completion()
        }
    }

    func resetState() {
        isUpdated = false
    }
}
