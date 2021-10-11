//
//  UIView+Reusable.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 11.10.2021.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}
