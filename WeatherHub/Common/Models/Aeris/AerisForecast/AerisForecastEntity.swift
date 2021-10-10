//
//  AerisForecastEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct AerisForecastEntity {

    public let periods: [AerisForecastDayEntity]

}

extension AerisForecastEntity: DTODecodable {
    public static func from(dto: AerisForecastEntry) throws -> AerisForecastEntity {
        return try .init(periods: .from(dto: dto.periods))
    }
}
