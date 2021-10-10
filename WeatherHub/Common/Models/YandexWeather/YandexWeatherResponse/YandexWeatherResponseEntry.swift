//
//  YandexWeatherResponseEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexWeatherResponseEntry: Codable {

    public let forecasts: [YandexForecastEntry]

}

extension YandexWeatherResponseEntry: RawMappable {
    public typealias Raw = Json
}
