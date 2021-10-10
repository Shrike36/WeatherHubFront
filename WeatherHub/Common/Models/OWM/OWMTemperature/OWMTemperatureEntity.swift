//
//  OWMTemperatureEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMTemperatureEntity {

    public let day: Int
    public let night: Int

}

extension OWMTemperatureEntity: DTODecodable {
    public static func from(dto: OWMTemperatureEntry) throws -> OWMTemperatureEntity {
        return .init(day: Int(dto.max.rounded()),
                     night: Int(dto.min.rounded()))
    }
}
