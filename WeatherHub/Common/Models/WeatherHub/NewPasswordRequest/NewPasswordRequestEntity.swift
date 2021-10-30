//
//  NewPasswordRequestEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct NewPasswordRequestEntity {

    public let code: String
    public let password: String

}

extension NewPasswordRequestEntity: DTOEncodable {

    public func toDTO() throws -> NewPasswordRequestEntry {
        return.init(code: code,
                    password: password)
    }

}
