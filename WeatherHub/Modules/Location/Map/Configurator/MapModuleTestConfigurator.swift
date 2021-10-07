//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class MapModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, output) = MapModuleConfigurator().configure()
        return (view, [output])
    }

}
