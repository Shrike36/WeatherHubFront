//
//  DateFormatter.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

import Foundation

class DateStringBuilder {

    // MARK: - Constants

    private enum Constants {
        static let dateFormat = "d MMM"
    }

    // MARK: - Private properties

    private let formatter = DateFormatter()

    // MARK: - Public methods

    func buildString(for date: Date, withDayName: Bool) -> String {
        formatter.setLocalizedDateFormatFromTemplate(Constants.dateFormat)
        guard withDayName else {
            return formatter.string(from: date)
        }

        if Calendar.current.isDateInToday(date) {
            return L10n.Date.today + formatter.string(from: date)
        }
        if Calendar.current.isDateInTomorrow(date) {
            return L10n.Date.tomorrow + formatter.string(from: date)
        }

        return formatter.string(from: date)
    }

}
