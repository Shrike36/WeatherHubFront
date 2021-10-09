//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PlacesViewInput: AnyObject, LoadingPresenter {
    /// Method for setup initial state of view
    func setupInitialState()
}
