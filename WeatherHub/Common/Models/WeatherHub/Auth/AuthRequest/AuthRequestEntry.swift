//
//  AuthRequestEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import NodeKit

public struct AuthRequestEntry: Codable {

    public let email: String
    public let password: String

}

extension AuthRequestEntry: RawMappable {
    public typealias Raw = Json
}
