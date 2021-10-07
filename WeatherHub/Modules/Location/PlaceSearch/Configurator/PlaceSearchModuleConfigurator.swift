//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias PlaceSearchModuleComponents = (
    view: UIViewController,
    output: PlaceSearchModuleOutput
)

final class PlaceSearchModuleConfigurator {

    func configure() -> PlaceSearchModuleComponents {
        let view = UIViewController.instantiate(ofType: PlaceSearchViewController.self)
        let presenter = PlaceSearchPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
