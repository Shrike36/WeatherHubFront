//
//  AerisForecastDayEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct AerisForecastDayEntity {

    public let maximalTemperature: Int
    public let minimalTemperature: Int
    public let weatherCode: String

}

extension AerisForecastDayEntity: DTODecodable {
    public static func from(dto: AerisForecastDayEntry) throws -> AerisForecastDayEntity {
        return .init(maximalTemperature: dto.maxTempC,
                     minimalTemperature: dto.minTempC,
                     weatherCode: dto.weatherPrimaryCoded)
    }
}
