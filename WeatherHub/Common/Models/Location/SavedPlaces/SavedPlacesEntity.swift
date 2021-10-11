//
//  SavedPlacesEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import NodeKit

public struct SavedPlacesEntity {

    // MARK: - Public Properties

    public let places: [PlaceEntity]

}

// MARK: - DTOConvertible

extension SavedPlacesEntity: DTOConvertible {

    public func toDTO() throws -> SavedPlacesEntry {
        return try .init(places: places.toDTO())
    }

    public static func from(dto: SavedPlacesEntry) throws -> SavedPlacesEntity {
        return try .init(places: .from(dto: dto.places))
    }

}
