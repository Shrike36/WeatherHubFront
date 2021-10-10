//
//  AerisResponseEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct AerisResponseEntry: Codable {

    public let response: [AerisForecastEntry]

}

extension AerisResponseEntry: RawMappable {
    public typealias Raw = Json
}
