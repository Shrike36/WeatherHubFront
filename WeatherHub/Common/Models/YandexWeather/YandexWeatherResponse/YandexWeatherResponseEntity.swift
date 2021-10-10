//
//  YandexWeatherResponseEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexWeatherResponseEntity {

    public let forecasts: [YandexForecastEntity]

}

extension YandexWeatherResponseEntity: DTODecodable {
    public static func from(dto: YandexWeatherResponseEntry) throws -> YandexWeatherResponseEntity {
        return try .init(forecasts: .from(dto: dto.forecasts))
    }
}

extension YandexWeatherResponseEntity: ForecastProvider {
    public func getForecastForDay(index: Int) -> WeatherViewModel {
        let forecast = forecasts[index]
        return WeatherViewModel(
            serviceName: L10n.Common.yandex,
            weatherConditions: .fromYandex(conditions: forecast.parts.day.conditions),
            dayTemperature: forecast.parts.day.temperature,
            nightTemperature: forecast.parts.night.temperature
        )
    }
}
