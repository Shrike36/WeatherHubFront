//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias MapModuleComponents = (
    view: UIViewController,
    output: MapModuleOutput
)

final class MapModuleConfigurator {

    func configure() -> MapModuleComponents {
        let view = UIViewController.instantiate(ofType: MapViewController.self)
        let presenter = MapPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
