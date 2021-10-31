//
//  PlacesService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 11.10.2021.
//

import Foundation

public class SavedPlacesService {

    // MARK: - Public Properties

    public static let shared = SavedPlacesService()

    public private(set) var savedPlaces = [PlaceEntity]()

    // MARK: - Private Properties

    private let storageService = StorageService()

    // MARK: - Initialization

    private init() {
        savedPlaces = storageService.savedPlaces
    }

    // MARK: - Public Methods

    func isSaved(place: PlaceEntity) -> Bool {
        return savedPlaces.contains { $0 == place }
    }

    func add(place: PlaceEntity) {
        guard !isSaved(place: place) else {
            return
        }
        savedPlaces.append(place)
        storageService.savedPlaces = savedPlaces
    }

    func add(places: [PlaceEntity]) {
        savedPlaces += places.filter { !isSaved(place: $0) }
        storageService.savedPlaces = savedPlaces
    }

    func remove(place: PlaceEntity) {
        savedPlaces.removeAll { $0 == place }
        storageService.savedPlaces = savedPlaces
    }

    func remove(at index: Int) {
        savedPlaces.remove(at: index)
        storageService.savedPlaces = savedPlaces
    }

    func clear() {
        savedPlaces.removeAll()
        storageService.savedPlaces = savedPlaces
    }

}
