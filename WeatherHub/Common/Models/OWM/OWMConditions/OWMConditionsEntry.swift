// swiftlint:disable identifier_name
//
//  OWMConditionsEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMConditionsEntry: Codable {

    public let id: Int

}

extension OWMConditionsEntry: RawMappable {
    public typealias Raw = Json
}

// swiftlint:enable identifier_name
