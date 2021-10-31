//
//  PlacesSynchronizationService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import Foundation

class PlacesSynchronizationService {

    // MARK: - Private Properties

    private let localService = SavedPlacesService.shared
    private let networkService = PlacesService()
    private let storageService = StorageService()

    // MARK: - Public Properties

    public var savedPlaces: [PlaceEntity] {
        localService.savedPlaces
    }

    // MARK: - Public Methods

    public func synchronize() {
        guard let user = storageService.user else {
            return
        }
        networkService.getPlaces(for: user)
            .map { zippedPlaces in
                zippedPlaces.compactMap { PlaceEntity.from(zipped: $0.zippedPlace) }
            }.onCompleted { [weak self] places in
                self?.handleLoaded(places: places, for: user)
            }
    }

    public func isSaved(place: PlaceEntity) -> Bool {
        return localService.isSaved(place: place)
    }

    public func add(place: PlaceEntity) {
        localService.add(place: place)
        if let user = storageService.user {
            _ = networkService.add(places: [place], for: user)
        }
    }

    public func remove(place: PlaceEntity) {
        localService.remove(place: place)
        if let user = storageService.user {
            _ = networkService.delete(place: place, for: user)
        }
    }

    public func remove(at index: Int) {
        let place = savedPlaces[index]
        localService.remove(at: index)
        if let user = storageService.user {
            _ = networkService.delete(place: place, for: user)
        }
    }

    public func clearLocal() {
        localService.clear()
    }

}

// MARK: - Private Methods

private extension PlacesSynchronizationService {

    func handleLoaded(places: [PlaceEntity], for user: UserEntity) {
        let localPlaces = Set(savedPlaces)
        let networkPlaces = Set(places)
        localService.add(places: .init(networkPlaces.subtracting(localPlaces)))
        _ = networkService.add(places: .init(localPlaces.subtracting(networkPlaces)), for: user)
    }

}
