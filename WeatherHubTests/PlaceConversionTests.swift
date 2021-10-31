//
//  PlaceConversionTests.swift
//  WeatherHubTests
//
//  Created by Дмитрий Демьянов on 06.05.2021.
//

import XCTest
@testable import WeatherHub

class PlaceConversionTests: XCTestCase {

    func testPlaceIsConvertedIntoStringAndBackCorrectly() {
        // Arrange
        let place = PlaceEntity(city: "Voronezh",
                                country: "Russia",
                                coordinates: .init(latitude: 51.657297, longitude: 39.204971))

        // Act
        let restoredPlace = PlaceEntity.from(zipped: place.zipped)

        // Assert
        XCTAssertEqual(place.city, restoredPlace?.city)
        XCTAssertEqual(place.country, restoredPlace?.country)
        XCTAssertEqual(place.coordinates.latitude, restoredPlace?.coordinates.latitude)
        XCTAssertEqual(place.coordinates.longitude, restoredPlace?.coordinates.longitude)
    }

}
