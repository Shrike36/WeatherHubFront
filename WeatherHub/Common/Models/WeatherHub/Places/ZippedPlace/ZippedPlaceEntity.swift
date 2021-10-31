//
//  ZippedPlaceEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct ZippedPlaceEntity {

    let zippedPlace: String

}

extension ZippedPlaceEntity: DTODecodable {
    public static func from(dto: ZippedPlaceEntry) throws -> ZippedPlaceEntity {
        return .init(zippedPlace: dto.coordinate)
    }
}
