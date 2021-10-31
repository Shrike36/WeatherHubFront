//
//  DeletePlaceRequestEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct DeletePlaceRequestEntry: Codable {

    public let email: String
    public let token: String
    public let coordinate: String

}

extension DeletePlaceRequestEntry: RawMappable {
    public typealias Raw = Json
}
