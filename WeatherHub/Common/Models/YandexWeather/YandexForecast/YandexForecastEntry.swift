//
//  YandexForecastEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexForecastEntry: Codable {

    public let parts: YandexForecastDayEntry

}

extension YandexForecastEntry: RawMappable {
    public typealias Raw = Json
}
