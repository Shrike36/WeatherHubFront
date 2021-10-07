//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

protocol MapViewOutput {
    func viewLoaded()
    func handleLocationSelected(_ location: CLLocationCoordinate2D)
}
