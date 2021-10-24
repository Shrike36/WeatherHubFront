//
//  AccountTableCell.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 25.10.2021.
//

import UIKit
import ReactiveDataDisplayManager

class AccountTableCell: UITableViewCell, ConfigurableItem {

    // MARK: - IBOutlets

    @IBOutlet private weak var accountLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var signOutButton: UIButton!

    // MARK: - Private Properties

    private var onLogOutRequested: EmptyClosure?

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - ConfigurableItem

    func configure(with model: AccountCellModel) {
        emailLabel.text = model.email
        onLogOutRequested = model.onLogOutRequested
    }

}

// MARK: - Private Methods

private extension AccountTableCell {

    func setupInitialState() {
        configureBackground()
        configureAccountLabel()
        configureSignOutButton()
    }

    func configureBackground() {
        backgroundColor = Asset.Colors.background.color
        contentView.backgroundColor = Asset.Colors.contrastBackground.color
        contentView.layer.cornerRadius = 10
    }

    func configureAccountLabel() {
        accountLabel.text = L10n.Settings.account
    }

    func configureSignOutButton() {
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        signOutButton.setTitleColor(Asset.Colors.destructiveAction.color, for: .normal)
        signOutButton.setTitle(L10n.Settings.signOut, for: .normal)
    }

}

// MARK: - Actions

private extension AccountTableCell {

    @IBAction
    func handleLogOutPressed() {
        onLogOutRequested?()
    }

}
