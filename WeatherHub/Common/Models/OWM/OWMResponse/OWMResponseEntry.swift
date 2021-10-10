//
//  OWMResponseEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMResponseEntry: Codable {

    public let daily: [OWMForecastDayEntry]

}

extension OWMResponseEntry: RawMappable {
    public typealias Raw = Json
}
