//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias TabBarModuleComponents = (
    view: UIViewController,
    input: TabBarModuleInput,
    output: TabBarModuleOutput
)

final class TabBarModuleConfigurator {

    func configure() -> TabBarModuleComponents {
        let view = UIViewController.instantiate(ofType: TabBarViewController.self)
        let presenter = TabBarPresenter()
        // Because view is loaded before presenter initialization
        presenter.viewLoaded()

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter)
    }

}
