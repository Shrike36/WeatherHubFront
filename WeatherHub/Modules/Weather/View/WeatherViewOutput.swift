//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol WeatherViewOutput {
    /// Notify presenter that view is ready
    func viewLoaded()
    /// Notify presenter that view layout is finished
    func layoutFinished()
    /// Notify presenter that user wants to see previous date
    func prevDateAsked()
    /// Notify presenter that user wants to see next date
    func nextDateAsked()
    /// Notify presenter that user scrolled to given index
    func scrolledToIndex(_ index: Int)
}
