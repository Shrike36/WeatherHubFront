//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class PlacesPresenter: PlacesModuleOutput {

    // MARK: - PlacesModuleOutput

    // MARK: - Properties

    weak var view: PlacesViewInput?

}

// MARK: - PlacesModuleInput

extension PlacesPresenter: PlacesModuleInput {
}

// MARK: - PlacesViewOutput

extension PlacesPresenter: PlacesViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
