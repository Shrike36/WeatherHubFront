//
//  Copyright © 2021 Surf. All rights reserved.
//

import UIKit

typealias NewPasswordModuleComponents = (
    view: UIViewController,
    output: NewPasswordModuleOutput
)

final class NewPasswordModuleConfigurator {

    func configure(with user: PasswordResetRequestEntity) -> NewPasswordModuleComponents {
        let view = UIViewController.instantiate(ofType: NewPasswordViewController.self)
        let presenter = NewPasswordPresenter(user: user)

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
