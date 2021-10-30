//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class PasswordResetPresenter: PasswordResetModuleOutput {

    // MARK: - PasswordResetModuleOutput

    var onBackPressed: EmptyClosure?
    var onErrorOccured: Closure<DetailedError>?
    var onRequestSuccess: Closure<PasswordResetRequestEntity>?

    // MARK: - Properties

    weak var view: PasswordResetViewInput?

    // MARK: - Private Properties

    private let authService = AuthService()

}

// MARK: - PasswordResetModuleInput

extension PasswordResetPresenter: PasswordResetModuleInput {
}

// MARK: - PasswordResetViewOutput

extension PasswordResetPresenter: PasswordResetViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func handleBackPressed() {
        onBackPressed?()
    }

    func handleSendPressed() {
        resetPassword()
    }

}

// MARK: - Private Methods

private extension PasswordResetPresenter {

    func resetPassword() {
        guard let email = view?.emailValue else {
            return
        }
        let userModel = PasswordResetRequestEntity(email: email)

        view?.showLoading()
        authService.resetPassword(for: userModel)
            .onCompleted { [weak self] in
                self?.onRequestSuccess?(userModel)
            }.onError { [weak self] _ in
                let error = DetailedError(title: L10n.ResetPassword.Error.title,
                                          details: L10n.ResetPassword.Error.details)
                self?.onErrorOccured?(error)
            }
            .defer { [weak self] in
                self?.view?.hideLoading()
            }
    }

}
