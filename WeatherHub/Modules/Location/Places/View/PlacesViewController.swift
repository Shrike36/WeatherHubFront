//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class PlacesViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let buttonBarCornerRadius: CGFloat = 15
        static let rowHeight: CGFloat = 95
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

    private var cellModels = [PlaceViewModel]()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.handlePlacesAppear()
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

    func fillPlaces(_ places: [PlaceViewModel]) {
        cellModels = places
        placesTable.reloadData()
        places.isEmpty ? showEmptyView(with: L10n.Places.empty) : hideEmptyView()
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PlacesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PlaceTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: cellModels[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.handlePlaceSelected(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: String(indexPath.row) as NSString,
                                          previewProvider: nil) { _ in
            let removeAction = UIAction(title: L10n.Places.remove,
                                        image: UIImage(systemSymbol: .trash),
                                        attributes: .destructive) { [weak self] _ in
                self?.output?.removePlace(at: indexPath.row)
                self?.removeCell(at: indexPath)
            }
            return UIMenu(title: "", image: nil, children: [removeAction])
        }
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
        placesTable.separatorStyle = .none
        placesTable.backgroundColor = .clear
        placesTable.showsVerticalScrollIndicator = false
        placesTable.rowHeight = UITableView.automaticDimension
        placesTable.estimatedRowHeight = Constants.rowHeight
        placesTable.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: Constants.rowHeight, right: .zero)

        let cellNib = UINib(nibName: PlaceTableViewCell.className, bundle: nil)
        placesTable.register(cellNib, forCellReuseIdentifier: PlaceTableViewCell.reuseIdentifier)
        placesTable.dataSource = self
        placesTable.delegate = self
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

    func removeCell(at indexPath: IndexPath) {
        cellModels.remove(at: indexPath.row)
        placesTable.deleteRows(at: [indexPath], with: .automatic)
        cellModels.isEmpty ? showEmptyView(with: L10n.Places.empty) : hideEmptyView()
    }

}

// MARK: - Actions

private extension PlacesViewController {

    @IBAction
    func handleSearchPressed(_ sender: Any) {
        output?.handleSearchNeeded()
    }

    @IBAction
    func handleMapPressed(_ sender: Any) {
        output?.handleMapNeeded()
    }

    @IBAction
    func handleLocationPressed(_ sender: Any) {
        output?.handleLocationRequested()
    }

}
