//
//  SavedPlacesEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import NodeKit

public struct SavedPlacesEntry: Codable {

    public let places: [PlaceEntry]

}

extension SavedPlacesEntry: RawMappable {
    public typealias Raw = Json
}
