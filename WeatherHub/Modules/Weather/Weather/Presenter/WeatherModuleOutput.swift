//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

protocol WeatherModuleOutput: AnyObject {
    var onAlertNeeded: Closure<UIAlertController>? { get set }
}
