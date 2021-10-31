//
//  EmptyView.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 31.10.2021.
//

import UIKit

class EmptyView: UIView {

    // MARK: - Constants

    static let tag = 841

    private enum Constants {
        static let size: CGFloat = 288
        static let textOffset: CGFloat = 16
    }

    // MARK: - Public Methods

    func configure(with text: String) {
        layer.cornerRadius = 20
        layer.masksToBounds = true

        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalToConstant: Constants.size),
            blurView.heightAnchor.constraint(equalToConstant: Constants.size),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = Asset.Colors.action.color.withAlphaComponent(0.7)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = text
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.size - 2 * Constants.textOffset)
        ])
    }

}
