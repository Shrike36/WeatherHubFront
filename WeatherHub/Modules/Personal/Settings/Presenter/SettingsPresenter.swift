//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class SettingsPresenter: SettingsModuleOutput {

    // MARK: - SettingsModuleOutput

    // MARK: - Properties

    weak var view: SettingsViewInput?

}

// MARK: - SettingsModuleInput

extension SettingsPresenter: SettingsModuleInput {
}

// MARK: - SettingsViewOutput

extension SettingsPresenter: SettingsViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
