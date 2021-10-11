//
//  PlaceEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import NodeKit

public struct PlaceEntry: Codable {

    public let city: String
    public let country: String
    public let latitude: Double
    public let longtitude: Double

}

extension PlaceEntry: RawMappable {
    public typealias Raw = Json
}
