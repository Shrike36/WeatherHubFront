// swiftlint:disable identifier_name
//
//  YandexForecastDayEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct YandexForecastDayEntry: Codable {

    public let day_short: YandexForecastPartEntry
    public let night_short: YandexForecastPartEntry

}

extension YandexForecastDayEntry: RawMappable {
    public typealias Raw = Json
}

// swiftlint:enable identifier_name
