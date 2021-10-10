//
//  ForecastProvider.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

public protocol ForecastProvider {
    func getForecastForDay(index: Int) -> WeatherViewModel
}
