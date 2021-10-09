//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class TabBarModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, _, output) = TabBarModuleConfigurator().configure()
        return (view, [output])
    }

}
