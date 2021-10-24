//
//  OWMUrlRoute.swift
//

import NodeKit

enum OWMUrlRoute {
    case forecast
}

// MARK: - UrlRouteProvider

extension OWMUrlRoute: UrlRouteProvider {

    func url() throws -> URL {
        let base = URL(string: Urls.openWeatherMap)
        switch self {
        case .forecast:
            return try base + "/onecall"
        }
    }

}
