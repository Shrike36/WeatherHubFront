//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class AuthModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, output) = AuthModuleConfigurator().configure()
        return (view, [output])
    }

}
