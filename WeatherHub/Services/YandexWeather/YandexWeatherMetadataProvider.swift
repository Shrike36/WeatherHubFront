//
//  YandexWeatherMetadataProvider.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

class YandexWeatherMetadataProvider: MetadataProvider {

    func metadata() -> [String: String] {
        ["X-Yandex-API-Key": ServiceKeys.yandex]
    }

}
