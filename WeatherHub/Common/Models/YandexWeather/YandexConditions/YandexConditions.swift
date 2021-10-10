//
//  YandexConditions.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import Foundation

public enum YandexConditions: String, Codable {
    case clear = "clear"
    case partlyCloudy = "partly-cloudy"
    case cloudy = "cloudy"
    case overcast = "overcast"
    case partlyCloudyLightRain = "partly-cloudy-and-light-rain"
    case partlyCloudyAndRain = "partly-cloudy-and-rain"
    case overcastRain = "overcast-and-rain"
    case overcastStorm = "overcast-thunderstorms-with-rain"
    case cloudyLightRain = "cloudy-and-light-rain"
    case overcastLightRain = "overcast-and-light-rain"
    case cloudyRain = "cloudy-and-rain"
    case overcastWetSnow = "overcast-and-wet-snow"
    case partlyCloudyLightSnow = "partly-cloudy-and-light-snow"
    case partlyCloudySnow = "partly-cloudy-and-snow"
    case overcastSnow = "overcast-and-snow"
    case cloudyLightSnow = "cloudy-and-light-snow"
    case overcasrLightSnow = "overcast-and-light-snow"
    case cloudySnow = "cloudy-and-snow"
}
