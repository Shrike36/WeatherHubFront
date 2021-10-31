//
//  UserEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import NodeKit

public struct UserEntity {

    public let email: String
    public let token: String

}

extension UserEntity: DTOConvertible {

    public static func from(dto: UserEntry) throws -> UserEntity {
        return .init(email: dto.email,
                     token: dto.token)
    }

    public func toDTO() throws -> UserEntry {
        return .init(email: email,
                     token: token)
    }

}
