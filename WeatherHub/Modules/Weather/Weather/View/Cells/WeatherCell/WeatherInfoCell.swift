//
//  WeatherInfoCell.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

import UIKit
import ReactiveDataDisplayManager

class WeatherInfoCell: UITableViewCell {

    // MARK: - Constants

    private enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 18, weight: .medium)
        static let dayTemperatureFont: UIFont = .systemFont(ofSize: 18, weight: .regular)
        static let nightTemperatureFont: UIFont = .systemFont(ofSize: 18, weight: .thin)
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var dayTemperatureLabel: UILabel!
    @IBOutlet private weak var nightTemperatureLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

}

extension WeatherInfoCell: ConfigurableItem {

    func configure(with model: WeatherViewModel) {
        titleLabel.text = model.serviceName
        weatherImageView.image = model.weatherConditions.image

        let formatter = TemperatureStringBuilder()
        dayTemperatureLabel.text = formatter.buildString(for: model.dayTemperature)
        nightTemperatureLabel.text = formatter.buildString(for: model.nightTemperature)
    }

}

extension WeatherInfoCell: CalculatableHeightItem {

    static func getHeight(forWidth width: CGFloat, with model: WeatherViewModel) -> CGFloat {
        return 100
    }

}

private extension WeatherInfoCell {

    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
        configureTitle()
        configureDayTemperatureLabel()
        configureNightTemperatureLabel()
        configureImage()
    }

    func configureTitle() {
        titleLabel.font = Constants.titleFont
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    func configureImage() {
        weatherImageView.layer.cornerRadius = 10
        weatherImageView.backgroundColor = Asset.Colors.shade.color
    }

    func configureDayTemperatureLabel() {
        dayTemperatureLabel.font = Constants.dayTemperatureFont
        dayTemperatureLabel.textAlignment = .right
    }

    func configureNightTemperatureLabel() {
        nightTemperatureLabel.font = Constants.nightTemperatureFont
        nightTemperatureLabel.textAlignment = .right
    }

}

private extension WeatherConditions {

    var image: UIImage {
        switch self {
        case .clouds:
            return Asset.Assets.cloud.image
        case .partialClouds:
            return Asset.Assets.sunAndClouds.image
        case .rain:
            return Asset.Assets.rain.image
        case .snow:
            return Asset.Assets.snow.image
        case .storm:
            return Asset.Assets.storm.image
        case .sun:
            return Asset.Assets.sun.image
        }
    }

}
