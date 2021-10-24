//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol SettingsViewInput: AnyObject {
    func setupInitialState()
    func setState(_ state: SettingsViewController.State)
}
