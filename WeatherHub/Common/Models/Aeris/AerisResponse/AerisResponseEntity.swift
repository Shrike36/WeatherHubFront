//
//  AerisResponseEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct AerisResponseEntity {

    public let forecasts: [AerisForecastEntity]

}

extension AerisResponseEntity: DTODecodable {
    public static func from(dto: AerisResponseEntry) throws -> AerisResponseEntity {
        return try .init(forecasts: .from(dto: dto.response))
    }
}

extension AerisResponseEntity: ForecastProvider {
    public func getForecastForDay(index: Int) -> WeatherViewModel {
        let forecast = forecasts[0].periods[index]
        return WeatherViewModel(
            serviceName: L10n.Common.aeris,
            weatherConditions: .fromAeris(weatherCode: forecast.weatherCode),
            dayTemperature: forecast.maximalTemperature,
            nightTemperature: forecast.minimalTemperature)
    }
}
