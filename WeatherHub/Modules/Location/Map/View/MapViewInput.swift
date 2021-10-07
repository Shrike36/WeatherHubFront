//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

protocol MapViewInput: AnyObject {
    func setupInitialState()
    func showLocation(_ location: CLLocation)
}
