//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

protocol WeatherModuleInput: AnyObject {
    func showWeather(for place: CLPlacemark)
}
