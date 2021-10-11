//
//  StorageService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import Foundation

public class StorageService {

    // MARK: - Keys

    private enum Keys {
        static let lastPlace = "lastPlace"
        static let savedPlaces = "savedPlaces"
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

}
