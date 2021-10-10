//
//  OWMForecastDayEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMForecastDayEntity {

    public let temperature: OWMTemperatureEntity
    public let conditions: OWMConditionsEntity

}

extension OWMForecastDayEntity: DTODecodable {
    public static func from(dto: OWMForecastDayEntry) throws -> OWMForecastDayEntity {
        return try .init(temperature: .from(dto: dto.temp),
                         conditions: .from(dto: dto.weather.first!))
    }
}
