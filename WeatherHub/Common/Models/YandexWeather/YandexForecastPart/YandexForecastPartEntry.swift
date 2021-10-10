//
//  YandexForecastPartEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexForecastPartEntry: Codable {

    public let temp: Int
    public let condition: YandexConditions

}

extension YandexForecastPartEntry: RawMappable {
    public typealias Raw = Json
}
