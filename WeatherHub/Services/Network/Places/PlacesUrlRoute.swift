//
//  PlacesUrlRoute.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

enum PlacesUrlRoute {
    case addPlaces
    case getPlaces
    case deletePlace
}

// MARK: - UrlRouteProvider

extension PlacesUrlRoute: UrlRouteProvider {

    func url() throws -> URL {
        let base = URL(string: Urls.weatherHub)
        switch self {
        case .addPlaces:
            return try base + "/user/add_places"
        case .getPlaces:
            return try base + "/user/get_places"
        case .deletePlace:
            return try base + "users/delete_place"
        }
    }

}
