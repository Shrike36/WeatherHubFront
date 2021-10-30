//
//  AuthRequestEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import NodeKit

public struct AuthRequestEntity {

    public let email: String
    public let password: String

}

extension AuthRequestEntity: DTOEncodable {

    public func toDTO() throws -> AuthRequestEntry {
        return.init(email: email,
                    password: password)
    }

}
