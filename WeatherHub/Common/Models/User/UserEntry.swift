//
//  UserEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import NodeKit

public struct UserEntry: Codable {

    let email: String
    let token: String

}

extension UserEntry: RawMappable {
    public typealias Raw = Json
}
