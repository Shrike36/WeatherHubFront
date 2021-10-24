//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import ReactiveDataDisplayManager
import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - Nested Types

    enum State {
        case authorized(email: String)
        case unauthorized
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    var output: SettingsViewOutput?

    // MARK: - Private Properties

    private lazy var ddm = tableView.rddm.baseBuilder
        .add(plugin: .selectable())
        .build()

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
        setState(.unauthorized)
    }

    func setState(_ state: State) {
        ddm.clearCellGenerators()

        switch state {
        case .authorized(let email):
            let cellModel = AccountCellModel(email: email) { [weak self] in
                self?.output?.logoutRequested()
            }
            let accountGenerator = AccountTableCell.rddm.baseGenerator(with: cellModel)
            ddm.addCellGenerator(accountGenerator)
        case .unauthorized:
            let loginGenerator = LoginTableCell.rddm.baseGenerator(with: ())
            loginGenerator.didSelectEvent += { [weak self] in
                self?.output?.loginRequested()
            }
            ddm.addCellGenerator(loginGenerator)
        }

        ddm.forceRefill()
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
        titleLabel.text = L10n.Settings.title
    }

    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }

}
