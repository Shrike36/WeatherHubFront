//
//  AerisForecastEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct AerisForecastEntry: Codable {

    public let periods: [AerisForecastDayEntry]

}

extension AerisForecastEntry: RawMappable {
    public typealias Raw = Json
}
