//
//  OWMResponseEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMResponseEntity {

    public let dailyForecasts: [OWMForecastDayEntity]

}

extension OWMResponseEntity: DTODecodable {
    public static func from(dto: OWMResponseEntry) throws -> OWMResponseEntity {
        return try .init(dailyForecasts: .from(dto: dto.daily))
    }
}

extension OWMResponseEntity: ForecastProvider {
    public func getForecastForDay(index: Int) -> WeatherViewModel {
        let forecast = dailyForecasts[index]
        return WeatherViewModel(
            serviceName: L10n.Common.owm,
            weatherConditions: .fromOWM(conditions: forecast.conditions.code),
            dayTemperature: forecast.temperature.day,
            nightTemperature: forecast.temperature.night
        )
    }
}
