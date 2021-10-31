//
//  PlacesUrlRoute.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

enum PlacesUrlRoute {
    case places
}

// MARK: - UrlRouteProvider

extension PlacesUrlRoute: UrlRouteProvider {

    func url() throws -> URL {
        let base = URL(string: Urls.weatherHub)
        switch self {
        case .places:
            return try base + "/user/places"
        }
    }

}
