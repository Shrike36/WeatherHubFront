//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class PasswordResetModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, output) = PasswordResetModuleConfigurator().configure()
        return (view, [output])
    }

}
