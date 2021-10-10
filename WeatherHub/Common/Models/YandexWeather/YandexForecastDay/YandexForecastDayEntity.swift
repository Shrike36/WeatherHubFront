//
//  YandexForecastDayEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexForecastDayEntity {

    public let day: YandexForecastPartEntity
    public let night: YandexForecastPartEntity

}

extension YandexForecastDayEntity: DTODecodable {
    public static func from(dto: YandexForecastDayEntry) throws -> YandexForecastDayEntity {
        return try .init(day: .from(dto: dto.day_short),
                     night: .from(dto: dto.night_short))
    }
}
