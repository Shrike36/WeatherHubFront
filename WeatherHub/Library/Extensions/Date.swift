//
//  Date.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 12.10.2021.
//

import Foundation

public extension Date {

    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

}
