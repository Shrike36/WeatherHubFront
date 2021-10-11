//
//  Encodable.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import Foundation

public extension Encodable {

    func toData(with encoder: JSONEncoder = JSONEncoder()) -> Data? {
        return try? encoder.encode(self)
    }

}
