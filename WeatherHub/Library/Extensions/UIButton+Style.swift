//
//  UIButton+Style.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 07.10.2021.
//

import UIKit

extension UIButton {

    func applyActionStyle() {
        layer.cornerRadius = 18
        layer.masksToBounds = true
        backgroundColor = Asset.Colors.tint.color
        titleLabel?.font = .boldSystemFont(ofSize: 18)
    }

}
