//
//  AuthUrlRoute.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import NodeKit

enum AuthUrlRoute {
    case register
    case auth
    case resetPassword
    case newPassword
}

// MARK: - UrlRouteProvider

extension AuthUrlRoute: UrlRouteProvider {

    func url() throws -> URL {
        let base = URL(string: Urls.weatherHub)
        switch self {
        case .register:
            return try base + "/register"
        case .auth:
            return try base + "/auth"
        case .resetPassword:
            return try base + "/reset_password_request"
        case .newPassword:
            return try base + "/reset_password"
        }
    }

}
