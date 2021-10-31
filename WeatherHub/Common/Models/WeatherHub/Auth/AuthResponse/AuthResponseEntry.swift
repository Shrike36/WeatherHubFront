//
//  AuthResponseEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import NodeKit

public struct AuthResponseEntry: Codable {

    let token: String

}

extension AuthResponseEntry: RawMappable {
    public typealias Raw = Json
}
