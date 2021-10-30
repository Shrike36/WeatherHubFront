//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias PasswordResetModuleComponents = (
    view: UIViewController,
    output: PasswordResetModuleOutput
)

final class PasswordResetModuleConfigurator {

    func configure() -> PasswordResetModuleComponents {
        let view = UIViewController.instantiate(ofType: PasswordResetViewController.self)
        let presenter = PasswordResetPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
