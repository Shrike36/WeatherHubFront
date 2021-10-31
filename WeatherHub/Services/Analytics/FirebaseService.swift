//
//  FirebaseService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 31.10.2021.
//

import Foundation
import Firebase
import CoreEvents
import Alamofire

class FirebaseService {

    // MARK: - Nested Types

    enum Event: String {
        case chooseCurrentPlace = "current_place_selected"
        case mapOpen = "map_screen_opened"
        case searchOpen = "search_screen_opened"
        case placeSelected = "place_selected"
        case addFavorite = "add_favorite"
        case removeFavorite = "remove_favorite"

        case authOpened = "auth_screen_opened"
        case authSuccess = "authorized_successfully"
        case logout = "logout"
    }

    enum Parameters {
        static let placeName = "place"
    }

    // MARK: - Public Methods

    public func track(event: Event, parameters: [String: Any]? = nil) {
        FirebaseAnalytics.Analytics.logEvent(event.rawValue, parameters: parameters)
    }

}
