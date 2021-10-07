//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class PlaceSearchModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, output) = PlaceSearchModuleConfigurator().configure()
        return (view, [output])
    }

}
