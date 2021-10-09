//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

protocol PlaceSearchModuleOutput: AnyObject {
    var onLocationSelected: Closure<CLLocationCoordinate2D>? { get set }
}
