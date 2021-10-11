//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

protocol PlacesModuleOutput: AnyObject {

    var onAlertNeeded: Closure<UIAlertController>? { get set }
    var onSearchNeeded: EmptyClosure? { get set }
    var onMapNeeded: EmptyClosure? { get set }

    var onPlaceSelected: Closure<PlaceEntity?>? { get set }
}
