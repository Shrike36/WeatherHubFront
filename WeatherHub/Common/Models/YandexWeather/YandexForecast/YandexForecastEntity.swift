//
//  YandexForecastEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexForecastEntity {

    public let parts: YandexForecastDayEntity

}

extension YandexForecastEntity: DTODecodable {
    public static func from(dto: YandexForecastEntry) throws -> YandexForecastEntity {
        return try .init(parts: .from(dto: dto.parts))
    }
}
