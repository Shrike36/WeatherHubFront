//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class WeatherModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, _, output) = WeatherModuleConfigurator().configure()
        return (view, [output])
    }

}
