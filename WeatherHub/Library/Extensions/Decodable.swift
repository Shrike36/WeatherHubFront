//
//  Decodable.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 10.10.2021.
//

import Foundation

public extension Decodable {

    init(data: Data, decoder: JSONDecoder = JSONDecoder()) throws {
        self = try decoder.decode(Self.self, from: data)
    }

}
