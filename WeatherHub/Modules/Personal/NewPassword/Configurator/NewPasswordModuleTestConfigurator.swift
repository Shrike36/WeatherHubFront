//
//  Copyright © 2021 Surf. All rights reserved.
//

import UIKit

final class NewPasswordModuleTestConfigurator {

    func configure(with user: PasswordResetRequestEntity) -> (UIViewController, [AnyObject]) {
        let (view, output) = NewPasswordModuleConfigurator().configure(with: user)
        return (view, [output])
    }

}
