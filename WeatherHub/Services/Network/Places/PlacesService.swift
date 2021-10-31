//
//  PlacesService.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public class PlacesService {

    // MARK: - Constants

    private enum Keys {
    }

    // MARK: - Private Properties

    private var builder: UrlChainsBuilder<PlacesUrlRoute> {
        return UrlChainsBuilder()
    }

    // MARK: - Public Methods

    public func add(places: [PlaceEntity], for user: UserEntity) -> Observer<Void> {
        let requestModel = AddPlacesRequestEntity(email: user.email, token: user.token, places: places)
        return builder
            .route(.post, .addPlaces)
            .build()
            .process(requestModel)
    }

    public func getPlaces(for user: UserEntity) -> Observer<[ZippedPlaceEntity]> {
        return builder
            .route(.get, .getPlaces)
            .set(query: [
                "email": user.email,
                "token": user.token
            ])
            .build()
            .process()
    }

    public func delete(place: PlaceEntity, for user: UserEntity) -> Observer<Void> {
        let requestModel = DeletePlaceRequestEntity(email: user.email, token: user.token, place: place)
        return builder
            .route(.delete, .deletePlace)
            .build()
            .process(requestModel)
    }

}
