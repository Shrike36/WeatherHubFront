//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import CoreLocation

protocol LocationCoordinatorOutput: AnyObject {
    var onPlaceSelected: Closure<CLPlacemark>? { get set }
}
