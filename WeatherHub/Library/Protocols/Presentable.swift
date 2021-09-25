//
//  Presentable.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.05.2021.
//

import UIKit

/// Describes object that can be presented in view hierarchy
public protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

    public func toPresent() -> UIViewController? {
        return self
    }

}
