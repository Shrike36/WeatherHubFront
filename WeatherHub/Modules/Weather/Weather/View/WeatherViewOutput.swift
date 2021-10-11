//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol WeatherViewOutput {
    func viewLoaded()
    func layoutFinished()
    func viewWillAppear()
    func prevDateAsked()
    func nextDateAsked()
    func scrolledToIndex(_ index: Int)
    func heartSelected(state: Bool)
}
