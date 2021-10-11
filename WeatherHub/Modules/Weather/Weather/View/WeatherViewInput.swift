//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import Foundation

protocol WeatherViewInput: AnyObject, LoadingPresenter {
    /// Method for setup initial state of view
    func setupInitialState()
    /// Method for filling view with data
    func configure(with model: WeatherScreenViewModel)
    /// Allows or denies user to switch date
    func setDateChangeButtonsVisisble(left: Bool, right: Bool)
    /// Scroll to date with given index
    func setDateScrollIndex(_ index: Int, animated: Bool)
    /// Updates date label with given date
    func setDateText(_ date: Date)
    /// Updates heart button state
    func setFavoriteState(isSaved: Bool)
}
