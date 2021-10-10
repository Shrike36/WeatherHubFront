//
//  OWMTemperatureEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMTemperatureEntry: Codable {

    public let max: Double
    public let min: Double

}

extension OWMTemperatureEntry: RawMappable {
    public typealias Raw = Json
}
