//
//  NewPasswordRequestEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct NewPasswordRequestEntry: Codable {

    public let code: String
    public let password: String

}

extension NewPasswordRequestEntry: RawMappable {
    public typealias Raw = Json
}
