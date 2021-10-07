//
//  MainTab.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.05.2021.
//

import UIKit
import SFSafeSymbols

enum MainTab: Int, CaseIterable {

    case location
    case weather
    case more

    // MARK: - Public properties

    var image: UIImage {
        switch self {
        case .location:
            return Asset.Assets.pin.image
        case .weather:
            return UIImage(systemSymbol: .umbrellaFill)
        case .more:
            return UIImage(systemSymbol: .ellipsisCircleFill)
        }
    }

    var title: String {
        switch self {
        case .location:
            return L10n.Tabs.location
        case .weather:
            return L10n.Tabs.weather
        case .more:
            return L10n.Tabs.more
        }
    }

}
