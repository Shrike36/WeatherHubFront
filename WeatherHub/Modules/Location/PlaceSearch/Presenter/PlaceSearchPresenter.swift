//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class PlaceSearchPresenter: PlaceSearchModuleOutput {

    // MARK: - PlaceSearchModuleOutput

    // MARK: - Properties

    weak var view: PlaceSearchViewInput?

}

// MARK: - PlaceSearchModuleInput

extension PlaceSearchPresenter: PlaceSearchModuleInput {
}

// MARK: - PlaceSearchViewOutput

extension PlaceSearchPresenter: PlaceSearchViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
