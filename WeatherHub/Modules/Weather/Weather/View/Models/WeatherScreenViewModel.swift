//
//  WeatherScreenViewModel.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

public struct WeatherScreenViewModel: Codable {

    // MARK: - Properties

    let cityName: String
    let dates: [DateViewModel]

}

extension WeatherScreenViewModel {

    /// Contains information from all services
    var isFull: Bool {
        (dates.first?.weather.count ?? 0 ) == WeatherSupplier.allCases.count
    }
}
