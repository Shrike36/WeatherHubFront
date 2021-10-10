//
//  YandexForecastPartEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexForecastPartEntity {

    public let temperature: Int
    public let conditions: YandexConditions

}

extension YandexForecastPartEntity: DTODecodable {
    public static func from(dto: YandexForecastPartEntry) throws -> YandexForecastPartEntity {
        return .init(temperature: dto.temp,
                     conditions: dto.condition)
    }
}
