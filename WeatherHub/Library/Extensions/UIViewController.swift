//
//  UIViewController.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.05.2021.
//

import UIKit
import Foundation

public extension UIViewController {

    /// Метод для созданния UIViewController из UINib
    static func instantiate<ViewController: UIViewController>(ofType: ViewController.Type) -> ViewController {
        return .init(nibName: ofType.className, bundle: Bundle(for: ofType))
    }

    /// Метод для созданния UIViewController из UINib с конкретным названием
    static func instantiate<ViewController: UIViewController>(ofType: ViewController.Type,
                                                              nibName: String) -> ViewController {
        return .init(nibName: nibName, bundle: Bundle(for: ofType))
    }

}
