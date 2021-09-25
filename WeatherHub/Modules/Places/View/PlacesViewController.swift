//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class PlacesViewController: UIViewController {

    // MARK: - Properties

    var output: PlacesViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - PlacesViewInput

extension PlacesViewController: PlacesViewInput {

    func setupInitialState() {
    }

}
