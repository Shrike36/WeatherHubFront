//
//  YandexWeatherUrlRoute.swift
//

import NodeKit

enum YandexWeatherUrlRoute {
    case forecast
}

// MARK: - UrlRouteProvider

extension YandexWeatherUrlRoute: UrlRouteProvider {

    func url() throws -> URL {
        let base = URL(string: Urls.yandex)
        switch self {
        case .forecast:
            return try base + "/forecast"
        }
    }

}
