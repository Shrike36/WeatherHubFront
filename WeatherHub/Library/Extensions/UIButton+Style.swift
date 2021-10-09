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

    func applyImageStyle(icon: UIImage) {
        let image: UIImage
        image = icon.withRenderingMode(.alwaysOriginal)

        setTitle("", for: .normal)
        setImage(image, for: .normal)
        setImage(image.mask(with: 0.5), for: .highlighted)
        setImage(image.mask(with: 0.5), for: .selected)
        layer.masksToBounds = true
    }
}
