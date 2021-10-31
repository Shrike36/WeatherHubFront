//
//  PasswordResetRequestEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 25.10.2021.
//

import NodeKit

public struct PasswordResetRequestEntity {

    public let email: String

}

extension PasswordResetRequestEntity: DTOEncodable {

    public func toDTO() throws -> PasswordResetRequestEntry {
        return.init(email: email)
    }

}
