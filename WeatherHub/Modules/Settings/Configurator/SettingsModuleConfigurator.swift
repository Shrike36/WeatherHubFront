//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias SettingsModuleComponents = (
    view: UIViewController,
    output: SettingsModuleOutput
)

final class SettingsModuleConfigurator {

    func configure() -> SettingsModuleComponents {
        let view = UIViewController.instantiate(ofType: SettingsViewController.self)
        let presenter = SettingsPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
