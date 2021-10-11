//
//  WeatherCoordinatorInput.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import CoreLocation

protocol WeatherCoordinatorInput: AnyObject {
    func showWeather(for place: PlaceEntity)
}
