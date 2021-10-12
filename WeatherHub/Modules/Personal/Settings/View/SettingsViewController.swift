//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    var output: SettingsViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {

    func setupInitialState() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureTitleLabel()
        configureBackground()
        configureTableView()
    }

}

// MARK: - Private Methods

private extension SettingsViewController {

    func configureBackground() {
        view.backgroundColor = Asset.Colors.background.color
    }

    func configureTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.Places.title
    }

    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }

}
