//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias AuthModuleComponents = (
    view: UIViewController,
    output: AuthModuleOutput
)

final class AuthModuleConfigurator {

    func configure() -> AuthModuleComponents {
        let view = UIViewController.instantiate(ofType: AuthViewController.self)
        let presenter = AuthPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
