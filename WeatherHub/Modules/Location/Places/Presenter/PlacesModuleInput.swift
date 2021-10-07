//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

protocol PlacesModuleInput: AnyObject {
    func handleLocationSelected(_ location: CLLocationCoordinate2D)
}
