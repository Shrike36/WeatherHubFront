//
//  YandexWeatherService.swift
//

import CoreLocation
import NodeKit

public class YandexWeatherService: WeatherService {

    // MARK: - Constants

    private enum Keys {
        static let latitude = "lat"
        static let longtitude = "lon"
        static let needHourly = "hours"
        static let needExtraInfo = "extra"
    }

    // MARK: - Private Properties

    private var builder: UrlChainsBuilder<YandexWeatherUrlRoute> {
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

private extension YandexWeatherService {

    func getForecast(for coordinates: CLLocationCoordinate2D) -> Observer<YandexWeatherResponseEntity> {
        return builder
            .add(provider: YandexWeatherMetadataProvider())
            .set(query: [
                Keys.latitude: coordinates.latitude,
                Keys.longtitude: coordinates.longitude,
                Keys.needHourly: false,
                Keys.needExtraInfo: false
            ])
            .route(.get, .forecast)
            .build()
            .process()
    }

}
