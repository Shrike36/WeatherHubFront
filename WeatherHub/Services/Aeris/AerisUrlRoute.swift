//
//  OWMUrlRoute.swift
//

import NodeKit

enum AerisUrlRoute {
    case forecast(place: String)
}

// MARK: - UrlRouteProvider

extension AerisUrlRoute: UrlRouteProvider {

    func url() throws -> URL {
        let base = URL(string: Urls.aeris)
        switch self {
        case .forecast(let place):
            return try base + "/forecasts/" + place
        }
    }

}
