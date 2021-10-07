//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class PlaceSearchViewController: UIViewController {

    // MARK: - Properties

    var output: PlaceSearchViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - PlaceSearchViewInput

extension PlaceSearchViewController: PlaceSearchViewInput {

    func setupInitialState() {
    }

}
