//
//  DateViewModel.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

import Foundation

public struct DateViewModel: Codable {

    // MARK: - Properties

    let date: Date
    let weather: [WeatherViewModel]

}
