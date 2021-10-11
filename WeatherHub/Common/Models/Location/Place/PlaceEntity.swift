//
//  PlaceEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import CoreLocation
import NodeKit

public struct PlaceEntity {

    // MARK: - Public Properties

    public let city: String
    public let country: String
    public let coordinates: CLLocationCoordinate2D

}

// MARK: - Equatable

extension PlaceEntity: Equatable {

    public static func == (lhs: PlaceEntity, rhs: PlaceEntity) -> Bool {
        return lhs.city == rhs.city && rhs.country == rhs.country
    }

}

// MARK: - DTOConvertible

extension PlaceEntity: DTOConvertible {

    public func toDTO() throws -> PlaceEntry {
        return .init(city: city,
                     country: country,
                     latitude: coordinates.latitude,
                     longtitude: coordinates.longitude)
    }

    public static func from(dto: PlaceEntry) throws -> PlaceEntity {
        return .init(city: dto.city,
                     country: dto.country,
                     coordinates: .init(latitude: dto.latitude, longitude: dto.longtitude))
    }

}
// MARK: - Initialization

extension PlaceEntity {

    public static func from(place: CLPlacemark) -> PlaceEntity? {
        guard
            let city = place.locality,
            let country = place.country,
            let coordinates = place.location?.coordinate
        else {
            return nil
        }
        return .init(city: city,
                     country: country,
                     coordinates: coordinates)
    }

}
