//
//  AddPlacesRequestEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct AddPlacesRequestEntity {

    public let email: String
    public let token: String
    public let places: [PlaceEntity]

}

extension AddPlacesRequestEntity: DTOEncodable {

    public func toDTO() throws -> AddPlacesRequestEntry {
        return .init(email: email,
                     token: token,
                     coordinates: places.map { $0.zipped })
    }

}
