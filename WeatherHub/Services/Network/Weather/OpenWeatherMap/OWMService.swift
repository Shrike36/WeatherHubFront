//
//  OWMService.swift
//

import CoreLocation
import NodeKit

public class OWMService: WeatherService {

    // MARK: - Constants

    private enum Keys {
        static let latitude = "lat"
        static let longtitude = "lon"
        static let units = "units"
        static let excludedParts = "exclude"
        static let apiKey = "appid"
    }

    private enum FixedValues {
        static let units = "metric"
        static let excludedParts = "current,minutely,hourly,alerts"
    }

    // MARK: - Private Properties

    private var builder: UrlChainsBuilder<OWMUrlRoute> {
        return UrlChainsBuilder()
    }

    // MARK: - WeatherService

    public func getForecast(for coordinates: CLLocationCoordinate2D,
                            completion: @escaping Closure<ForecastProvider>,
                            deferred: @escaping EmptyClosure) {
        getForecast(for: coordinates)
            .defer {
                deferred()
            }.onCompleted { response in
                completion(response)
            }
    }

}

// MARK: - Private Methods

private extension OWMService {

    func getForecast(for coordinates: CLLocationCoordinate2D) -> Observer<OWMResponseEntity> {
        return builder
            .set(query: [
                Keys.latitude: coordinates.latitude,
                Keys.longtitude: coordinates.longitude,
                Keys.units: FixedValues.units,
                Keys.excludedParts: FixedValues.excludedParts,
                Keys.apiKey: ServiceKeys.openWeatherMap
            ])
            .route(.get, .forecast)
            .build()
            .process()
    }

}
