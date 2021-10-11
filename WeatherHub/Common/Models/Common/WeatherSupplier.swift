//
//  WeatherSupplier.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public enum WeatherSupplier: CaseIterable {
    case yandex
    case openWeatherMap
    case aeris
}

public extension WeatherSupplier {

    func makeService() -> WeatherService {
        switch self {
        case .yandex:
            return YandexWeatherService()
        case .openWeatherMap:
            return OWMService()
        case .aeris:
            return AerisService()
        }
    }

}
