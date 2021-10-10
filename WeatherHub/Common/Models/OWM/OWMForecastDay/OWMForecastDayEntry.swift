//
//  OWMForecastDayEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMForecastDayEntry: Codable {

    public let temp: OWMTemperatureEntry
    public let weather: [OWMConditionsEntry]

}

extension OWMForecastDayEntry: RawMappable {
    public typealias Raw = Json
}
