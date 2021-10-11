//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import ReactiveDataDisplayManager
import SurfUtils
import UIKit

final class PlaceSearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: SearchBar!
    @IBOutlet private weak var resultsTable: UITableView!

    // MARK: - Properties

    var output: PlaceSearchViewOutput?

    // MARK: - Private Properties

    private lazy var ddm = resultsTable.rddm.baseBuilder
        .add(plugin: .selectable())
        .build()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeOnKeyboardNotifications()
        searchBar.makeFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

}

// MARK: - PlaceSearchViewInput

extension PlaceSearchViewController: PlaceSearchViewInput {

    func setupInitialState() {
        view.backgroundColor = Asset.Colors.background.color
        configureSearchBar()
        configureTable()
    }

    func fillResults(_ results: [PlaceViewModel]) {
        ddm.clearCellGenerators()
        for item in results.enumerated() {
            let generator = PlaceTableViewCell.rddm.baseGenerator(with: item.element)
            generator.didSelectEvent += { [weak self] in
                self?.output?.resultSelected(at: item.offset)
            }
            ddm.addCellGenerator(generator)
        }
        ddm.forceRefill()
    }

}

extension PlaceSearchViewController: KeyboardObservable, CommonKeyboardPresentable {

    public func keyboardWillBeShown(keyboardHeight: CGFloat, duration: TimeInterval) {
        searchBar.changeCancelButonVisibility(isVisible: true)
        resultsTable.contentInset.bottom = keyboardHeight
    }

    public func keyboardWillBeHidden(duration: TimeInterval) {
        searchBar.changeCancelButonVisibility(isVisible: false)
        resultsTable.contentInset.bottom = .zero
    }

}

// MARK: - Private Methods

private extension PlaceSearchViewController {

    func configureSearchBar() {
        searchBar.placeholder = L10n.Search.search
        searchBar.setVoiceSearch(available: false)

        searchBar.onCancel = { [weak self] in
            self?.searchBar.text = ""
            self?.closeKeyboard()
        }

        searchBar.onTextChanged = { [weak self] text in
            self?.output?.inputChanged(text: text)
        }

        searchBar.onShouldReturn = { [weak self] in
            self?.closeKeyboard()
            return true
        }
    }

    func configureTable() {
        resultsTable.separatorStyle = .none
        resultsTable.backgroundColor = .clear
        resultsTable.showsVerticalScrollIndicator = false
    }

    func closeKeyboard() {
        view.endEditing(true)
        navigationController?.navigationBar.endEditing(true)
    }
}
