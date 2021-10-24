//
//  LoginTableCell.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 17.10.2021.
//

import ReactiveDataDisplayManager
import UIKit

class LoginTableCell: UITableViewCell, ConfigurableItem {

    // MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - ConfigurableItem

    func configure(with model: Void) {
    }

}

// MARK: - Private Methods

private extension LoginTableCell {

    func setupInitialState() {
        backgroundColor = Asset.Colors.background.color
        contentView.backgroundColor = Asset.Colors.contrastBackground.color
        contentView.layer.cornerRadius = 10

        titleLabel.text = L10n.Settings.Login.title
        detailsLabel.text = L10n.Settings.Login.description
    }

}
