//
//  ZippedPlaceEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct ZippedPlaceEntry: Codable {

    let coordinate: String

}

extension ZippedPlaceEntry: RawMappable {
    public typealias Raw = Json
}
