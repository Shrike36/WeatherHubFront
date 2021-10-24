//
//  AuthResponseEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import NodeKit

public struct AuthResponseEntity {

    let token: String

}

extension AuthResponseEntity: DTODecodable {
    public static func from(dto: AuthResponseEntry) throws -> AuthResponseEntity {
        return .init(token: dto.token)
    }
}
