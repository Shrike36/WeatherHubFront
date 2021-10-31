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
    private let placesService = PlacesSynchronizationService()
    private let analyticsService = FirebaseService()

}

// MARK: - SettingsModuleInput

extension SettingsPresenter: SettingsModuleInput {

    func updateState() {
        updateState(afterSignIn: true)
    }

}

// MARK: - SettingsViewOutput

extension SettingsPresenter: SettingsViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        updateState(afterSignIn: false)
    }

    func loginRequested() {
        onLoginRequested?()
    }

    func logoutRequested() {
        placesService.clearLocal()
        storageService.user = nil
        updateState(afterSignIn: false)
        analyticsService.track(event: .logout)
    }

}

// MARK: - Private Methods

private extension SettingsPresenter {

    func updateState(afterSignIn: Bool) {
        if let user = storageService.user {
            view?.setState(.authorized(email: user.email))
            if afterSignIn {
                placesService.synchronize()
                analyticsService.track(event: .authSuccess)
            }
        } else {
            view?.setState(.unauthorized)
        }
    }

}
