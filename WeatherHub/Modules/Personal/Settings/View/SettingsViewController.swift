//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - Properties

    var output: SettingsViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {

    func setupInitialState() {
    }

}
