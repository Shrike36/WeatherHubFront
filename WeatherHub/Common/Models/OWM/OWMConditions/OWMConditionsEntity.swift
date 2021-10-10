//
//  OWMConditionsEntity.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import NodeKit

public struct OWMConditionsEntity {

    public let code: Int

}

extension OWMConditionsEntity: DTODecodable {
    public static func from(dto: OWMConditionsEntry) throws -> OWMConditionsEntity {
        return .init(code: dto.id)
    }
}
