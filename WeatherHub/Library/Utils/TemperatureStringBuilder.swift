//
//  TemperatureStringBuilder.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

import Foundation

class TemperatureStringBuilder {

    // MARK: - Constants

    private enum Constants {
        static let degree = "°"
    }

    // MARK: - Private properties

    // MARK: - Public methods

    func buildString(for temperature: Int) -> String {
        return sign(for: temperature) + String(temperature) + Constants.degree
    }

}

// MARK: - Private methods

private extension TemperatureStringBuilder {

    func sign(for temperature: Int) -> String {
        switch temperature {
        case ...0:
            return ""
        default:
            return "+"
        }
    }

}
