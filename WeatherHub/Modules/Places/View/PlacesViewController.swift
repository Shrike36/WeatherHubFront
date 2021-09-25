//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class PlacesViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let buttonBarCornerRadius: CGFloat = 15
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var placesTable: UITableView!
    @IBOutlet private weak var buttonBar: UIView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var mapButton: UIButton!
    @IBOutlet private weak var locationButton: UIButton!

    // MARK: - Properties

    var output: PlacesViewOutput?

    // MARK: - Private Properties

    private var buttons: [UIButton] {
        return [searchButton, mapButton, locationButton]
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - PlacesViewInput

extension PlacesViewController: PlacesViewInput {

    func setupInitialState() {
        configureAppearance()
        configureTitle()
        configurePlacesTable()
        configureButtonBar()
    }

}

// MARK: - Private Methods

private extension PlacesViewController {

    func configureAppearance() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = Asset.Colors.background.color
    }

    func configureTitle() {
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textAlignment = .center
        titleLabel.text = L10n.Places.title
    }

    func configurePlacesTable() {
    }

    func configureButtonBar() {
        buttonBar.backgroundColor = Asset.Colors.background.color
        buttonBar.layer.cornerRadius = Constants.buttonBarCornerRadius

        searchButton.setImage(.magnifyingglass, for: .normal)
        mapButton.setImage(.map, for: .normal)
        locationButton.setImage(.location, for: .normal)
        buttons.forEach {
            $0.tintColor = Asset.Colors.action.color
            $0.backgroundColor = Asset.Colors.contrastBackground.color
            $0.layer.cornerRadius = Constants.buttonBarCornerRadius
        }
    }

}

// MARK: - Actions

private extension PlacesViewController {

    @IBAction
    func handleSearchPressed(_ sender: Any) {
    }

    @IBAction
    func handleMapPressed(_ sender: Any) {
    }

    @IBAction
    func handleLocationPressed(_ sender: Any) {
        output?.handleLocationRequested()
    }

}
