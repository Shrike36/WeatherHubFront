//
//  PasswordResetRequestEntry.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 25.10.2021.
//

import NodeKit

public struct PasswordResetRequestEntry: Codable {

    let email: String

}

extension PasswordResetRequestEntry: RawMappable {
    public typealias Raw = Json
}
