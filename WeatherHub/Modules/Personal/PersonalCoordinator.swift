//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit
import SurfUtils

final class PersonalCoordinator: BaseCoordinator, PersonalCoordinatorOutput {

    // MARK: - PersonalCoordinatorOutput

    // MARK: - Private Properties

    private let router: Router

    private weak var settingsInput: SettingsModuleInput?

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Coordinator

    override func start() {
        showSettings()
    }

}

// MARK: - Private Methods

private extension PersonalCoordinator {

    func showSettings() {
        let components = SettingsModuleConfigurator().configure()
        settingsInput = components.input
        components.output.onLoginRequested = { [weak self] in
            self?.showAuth()
        }
        router.setNavigationControllerRootModule(components.view, animated: false, hideBar: false)
    }

    func showAuth() {
        let components = AuthModuleConfigurator().configure()
        components.output.onErrorOccured = { [weak self] error in
            self?.showErrorAlert(with: error)
        }
        components.output.onAuthSuccess = { [weak self] in
            self?.router.dismissModule()
            self?.settingsInput?.updateState()
        }
        components.output.onPasswordResetRequested = { [weak self] in
            self?.showPasswordReset()
        }
        router.present(components.view)
    }

    func showPasswordReset() {
        let components = PasswordResetModuleConfigurator().configure()
        components.output.onBackPressed = { [weak self] in
            self?.router.popModule()
        }
        components.output.onErrorOccured = { [weak self] error in
            self?.showErrorAlert(with: error)
        }
        components.output.onRequestSuccess = { [weak self] user in
            self?.showNewPassword(for: user)
        }
        router.push(components.view)
    }

    func showNewPassword(for user: PasswordResetRequestEntity) {
        let components = NewPasswordModuleConfigurator().configure(with: user)
        components.output.onBackPressed = { [weak self] in
            self?.router.popModule()
        }
        components.output.onErrorOccured = { [weak self] error in
            self?.showErrorAlert(with: error)
        }
        components.output.onRequestSuccess = { [weak self] in
            self?.router.dismissModule()
            self?.settingsInput?.updateState()
        }
        router.push(components.view)
    }

    func showErrorAlert(with error: DetailedError) {
        let alert = UIAlertController(
            title: error.title,
            message: error.details,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        VibrationFeedbackManager.playHapticFeedbackBy(type: .error)
        router.present(alert)
    }

}
