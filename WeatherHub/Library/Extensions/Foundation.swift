//
//  Foundation.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.05.2021.
//

import Foundation

public extension NSObject {

    @objc class var className: String {
        if let name = NSStringFromClass(self).components(separatedBy: ".").last {
            return name
        }
        return ""
    }

    @objc var className: String {
        if let name = NSStringFromClass(type(of: self)).components(separatedBy: ".").last {
            return name
        }
        return ""
    }

}
