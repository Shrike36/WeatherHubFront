//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class PlacesModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, input, output) = PlacesModuleConfigurator().configure()
        return (view, [input, output])
    }

}
