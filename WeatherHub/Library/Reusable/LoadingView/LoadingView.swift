//
//  LoadingView.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Constants

    static let tag = 839

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialState()
    }

}

// MARK: - Private Methods

private extension LoadingView {

    func setupInitialState() {
        backgroundColor = .clear

        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blurView.frame = bounds
        addSubview(blurView)

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = Asset.Colors.action.color.withAlphaComponent(0.7)
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.Common.loading
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: spinner.topAnchor, constant: -20)
        ])
    }

}
