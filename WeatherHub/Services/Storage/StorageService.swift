//
//  StorageService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import Foundation
import KeychainAccess

public class StorageService {

    // MARK: - Keys

    private enum Keys {
        static let lastPlace = "lastPlace"
        static let savedPlaces = "savedPlaces"
        static let weatherCache = "weatherCache"
        static let userEmail = "email"
        static let token = "token"
    }

    // MARK: - Public Properties

    public var lastPlace: PlaceEntity? {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.lastPlace) else {
                return nil
            }
            return try? PlaceEntity.from(dto: .init(data: data))
        }
        set {
            guard let data = try? newValue?.toDTO().toData() else {
                return
            }
            UserDefaults.standard.set(data, forKey: Keys.lastPlace)
        }
    }

    public var savedPlaces: [PlaceEntity] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.savedPlaces) else {
                return []
            }
            return (try? [PlaceEntity].from(dto: .init(data: data))) ?? []
        }
        set {
            guard let data = try? newValue.toDTO().toData() else {
                return
            }
            UserDefaults.standard.set(data, forKey: Keys.savedPlaces)
        }
    }

    public var weatherCache: WeatherBackup? {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.weatherCache) else {
                return nil
            }
            return try? .init(data: data)
        }
        set {
            guard let data = newValue?.toData() else {
                return
            }
            UserDefaults.standard.set(data, forKey: Keys.weatherCache)
        }
    }

    public var user: UserEntry? {
        get {
            guard let email = try? keychain.get(Keys.userEmail), let token = try? keychain.get(Keys.token) else {
                return nil
            }
            return UserEntry(email: email, token: token)
        }
        set {
            if let user = newValue {
                try? keychain.set(user.email, key: Keys.userEmail)
                try? keychain.set(user.token, key: Keys.token)
            } else {
                try? keychain.remove(Keys.userEmail)
                try? keychain.remove(Keys.token)
            }
        }
    }

    // MARK: - Private Properties

    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")
}
