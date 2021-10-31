//
//  DeletePlaceRequestEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct DeletePlaceRequestEntity {

    public let email: String
    public let token: String
    public let place: PlaceEntity

}

extension DeletePlaceRequestEntity: DTOEncodable {

    public func toDTO() throws -> DeletePlaceRequestEntry {
        return .init(email: email,
                     token: token,
                     coordinate: place.zipped)
    }

}
