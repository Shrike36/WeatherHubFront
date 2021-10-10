//
//  WeatherConditions.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

public enum WeatherConditions: CaseIterable {
    case clouds
    case partialClouds
    case rain
    case snow
    case storm
    case sun
}

extension WeatherConditions {

    static func fromYandex(conditions: YandexConditions) -> WeatherConditions {
        switch conditions {
        case .clear:
            return .sun
        case .partlyCloudy:
            return .partialClouds
        case .cloudy, .overcast:
            return .clouds
        case .partlyCloudyLightRain, .partlyCloudyAndRain, .overcastRain, .cloudyLightRain, .overcastLightRain, .cloudyRain:
            return .rain
        case .overcastWetSnow, .partlyCloudyLightSnow, .partlyCloudySnow, .overcastSnow, .cloudyLightSnow, .overcasrLightSnow, .cloudySnow:
            return .snow
        case .overcastStorm:
            return .storm
        }
    }

    static func fromOWM(conditions: Int) -> WeatherConditions {
        switch conditions {
        case 200...299:
            // Thunderstorm
            return .storm
        case 300...399:
            // Drizzle
            return .rain
        case 500...599:
            // Rain
            return .rain
        case 600...699:
            // Snow
            return .snow
        case 700...799:
            // Atmosphere
            return .clouds
        case 800:
            // Clear
            return .sun
        case 801...801:
            // Clouds < 50%
            return .partialClouds
        case 803...804:
            // Clouds > 50%
            return .clouds
        default:
            // Unknown
            return .sun
        }
    }

    static func fromAeris(weatherCode: String) -> WeatherConditions {
        let codeParts = weatherCode.components(separatedBy: ":")
        let conditions = codeParts.last
        switch conditions {
        case "FW", "SC":
            return .partialClouds
        case "BK", "OV", "BD", "BN":
            return .clouds
        case "A", "BY", "L", "R", "RW", "ZR", "ZY":
            return .rain
        case "BS", "IC", "IP", "RS", "SI", "WM", "S", "SW", "ZL":
            return .snow
        case "T", "WP":
            return .storm
        default:
            return .sun
        }
    }

}
