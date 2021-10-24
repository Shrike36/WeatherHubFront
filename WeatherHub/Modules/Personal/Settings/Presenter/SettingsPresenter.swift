//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class SettingsPresenter: SettingsModuleOutput {

    // MARK: - SettingsModuleOutput

    var onLoginRequested: EmptyClosure?

    // MARK: - Properties

    weak var view: SettingsViewInput?

    // MARK: - Private Properties

    private let storageService = StorageService()

}

// MARK: - SettingsModuleInput

extension SettingsPresenter: SettingsModuleInput {

    func updateState() {
        if let user = storageService.user {
            view?.setState(.authorized(email: user.email))
        } else {
            view?.setState(.unauthorized)
        }
    }

}

// MARK: - SettingsViewOutput

extension SettingsPresenter: SettingsViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        updateState()
    }

    func loginRequested() {
        onLoginRequested?()
    }

    func logoutRequested() {
        storageService.user = nil
        updateState()
    }

}
