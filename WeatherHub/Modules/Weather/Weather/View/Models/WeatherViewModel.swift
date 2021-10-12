//
//  WeatherViewModel.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

import Foundation

public struct WeatherViewModel: Codable {

    // MARK: - Properties

    let serviceName: String
    let weatherConditions: WeatherConditions
    let dayTemperature: Int
    let nightTemperature: Int

}

extension WeatherViewModel {

    static func fromYandex(forecast: YandexForecastEntity) -> WeatherViewModel {
        return WeatherViewModel(
            serviceName: L10n.Common.yandex,
            weatherConditions: .fromYandex(conditions: forecast.parts.day.conditions),
            dayTemperature: forecast.parts.day.temperature,
            nightTemperature: forecast.parts.night.temperature
        )
    }

    static func fromOWM(forecast: OWMForecastDayEntity) -> WeatherViewModel {
        return WeatherViewModel(
            serviceName: L10n.Common.owm,
            weatherConditions: .fromOWM(conditions: forecast.conditions.code),
            dayTemperature: forecast.temperature.day,
            nightTemperature: forecast.temperature.night
        )
    }

}
