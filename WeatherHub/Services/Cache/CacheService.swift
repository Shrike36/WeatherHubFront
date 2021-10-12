//
//  CacheService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 12.10.2021.
//

import Foundation

public class CacheService {

    // MARK: -  Constants

    private enum Constants {
        static let expirationTime = 10
    }

    // MARK: - Private Properties

    private let storageService = StorageService()

    // MARK: - Public Methods

    func save(weather: WeatherScreenViewModel, for place: PlaceEntity) {
        guard let place = try? place.toDTO(), weather.isFull else {
            return
        }
        let backup = WeatherBackup(place: place,
                                   weather: weather,
                                   creationDate: Date())
        storageService.weatherCache = backup
    }

    func getCache(for place: PlaceEntity) -> WeatherBackup? {
        guard
            let backup = storageService.weatherCache,
            let savedPlace = try? PlaceEntity.from(dto: backup.place),
            savedPlace == place,
            backup.creationDate.minutes(from: Date()) < Constants.expirationTime
        else {
            return nil
        }
        return backup
    }
}
