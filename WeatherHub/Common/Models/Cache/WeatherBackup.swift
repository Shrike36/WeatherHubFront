//
//  WeatherBackup.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 12.10.2021.
//

import Foundation

public struct WeatherBackup: Codable {

    public let place: PlaceEntry
    public let weather: WeatherScreenViewModel
    public let creationDate: Date

}
