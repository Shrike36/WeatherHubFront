//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class SettingsModuleTestConfigurator {

    func configure() -> (UIViewController, [AnyObject]) {
        let (view, _, output) = SettingsModuleConfigurator().configure()
        return (view, [output])
    }

}
