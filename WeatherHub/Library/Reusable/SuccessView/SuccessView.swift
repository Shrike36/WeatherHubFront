//
//  SuccessView.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import UIKit

class SuccessView: UIView {

    // MARK: - Constants

    static let tag = 840
    static let showDuration: TimeInterval = 1

    // MARK: - Properties

    var hideCompletion: EmptyClosure?

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

private extension SuccessView {

    func setupInitialState() {
        backgroundColor = .clear

        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blurView.frame = bounds
        addSubview(blurView)

        let tickView = UIImageView(image: Asset.Assets.tick.image)
        tickView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tickView)
        NSLayoutConstraint.activate([
            tickView.widthAnchor.constraint(equalToConstant: 37),
            tickView.heightAnchor.constraint(equalToConstant: 37),
            tickView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tickView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = Asset.Colors.action.color.withAlphaComponent(0.7)
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.Common.done
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: tickView.topAnchor, constant: -20)
        ])
    }

}
