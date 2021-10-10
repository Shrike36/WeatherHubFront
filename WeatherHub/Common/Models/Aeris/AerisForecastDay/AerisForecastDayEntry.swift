//
//  AerisForecastDayEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct AerisForecastDayEntry: Codable {

    public let maxTempC: Int
    public let minTempC: Int
    public let weatherPrimaryCoded: String

}

extension AerisForecastDayEntry: RawMappable {
    public typealias Raw = Json
}
