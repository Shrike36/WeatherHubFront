//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

typealias WeatherModuleComponents = (
    view: UIViewController,
    output: WeatherModuleOutput
)

final class WeatherModuleConfigurator {

    func configure() -> WeatherModuleComponents {
        let view = UIViewController.instantiate(ofType: WeatherViewController.self)
        let presenter = WeatherPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
