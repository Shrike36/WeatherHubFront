//
//  WeatherService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import CoreLocation
import NodeKit

public protocol WeatherService {
    func getForecast(for coordinates: CLLocationCoordinate2D,
                     completion: @escaping Closure<ForecastProvider>,
                     deferred: @escaping EmptyClosure)
}
