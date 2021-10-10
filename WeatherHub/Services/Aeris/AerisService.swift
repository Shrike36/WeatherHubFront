//
//  AerisService.swift
//

import CoreLocation
import NodeKit

public class AerisService: WeatherService {

    // MARK: - Constants

    private enum Keys {
        static let responseFormat = "format"
        static let filter = "filter"
        static let fields = "fields"
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
    }

    private enum FixedValues {
        static let responseFormat = "json"
        static let filter = "day"
        static let fields = "periods.maxTempC,periods.minTempC,periods.weatherPrimaryCoded"
    }

    // MARK: - Private Properties

    private var builder: UrlChainsBuilder<AerisUrlRoute> {
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

private extension AerisService {

    func getForecast(for coordinates: CLLocationCoordinate2D) -> Observer<AerisResponseEntity> {
        return builder
            .set(query: [
                Keys.responseFormat: FixedValues.responseFormat,
                Keys.filter: FixedValues.filter,
                Keys.fields: FixedValues.fields,
                Keys.clientId: ServiceKeys.Aeris.clientId,
                Keys.clientSecret: ServiceKeys.Aeris.clientSecret
            ])
            .route(.get, .forecast(place: coordinates.toAerisFormat()))
            .build()
            .process()
    }

}

private extension CLLocationCoordinate2D {

    func toAerisFormat() -> String {
        return [latitude, longitude]
            .map { String($0) }
            .joined(separator: ",")
    }

}
