//
//  AddPlacesRequestEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct AddPlacesRequestEntry: Codable {

    public let email: String
    public let token: String
    public let coordinates: [String]

}

extension AddPlacesRequestEntry: RawMappable {
    public typealias Raw = Json
}
