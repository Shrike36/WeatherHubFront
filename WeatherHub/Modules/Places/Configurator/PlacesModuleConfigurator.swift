//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias PlacesModuleComponents = (
    view: UIViewController,
    output: PlacesModuleOutput
)

final class PlacesModuleConfigurator {

    func configure() -> PlacesModuleComponents {
        let view = UIViewController.instantiate(ofType: PlacesViewController.self)
        let presenter = PlacesPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
