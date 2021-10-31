//
//  Copyright © 2021 Surf. All rights reserved.
//

import Dispatch

final class NewPasswordPresenter: NewPasswordModuleOutput {

    // MARK: - NewPasswordModuleOutput

    var onBackPressed: EmptyClosure?
    var onErrorOccured: Closure<DetailedError>?
    var onRequestSuccess: EmptyClosure?

    // MARK: - Properties

    weak var view: NewPasswordViewInput?

    // MARK: - Private Properties

    private let userModel: PasswordResetRequestEntity

    private let authService = AuthService()
    private let storageService = StorageService()

    // MARK: - Initialization

    init(user: PasswordResetRequestEntity) {
        self.userModel = user
    }

}

// MARK: - NewPasswordModuleInput

extension NewPasswordPresenter: NewPasswordModuleInput {
}

// MARK: - NewPasswordViewOutput

extension NewPasswordPresenter: NewPasswordViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func handleBackPressed() {
        onBackPressed?()
    }

    func handleSendPressed() {
        setNewPassword()
    }

}

// MARK: - Private Methods

private extension NewPasswordPresenter {

    func setNewPassword() {
        guard let code = view?.codeValue, let password = view?.passwordValue, view?.isPasswordRepeated == true else {
            return
        }

        view?.showLoading()
        authService.setNewPassword(NewPasswordRequestEntity(code: code, password: password))
            .onCompleted { [weak self] response in
                guard let self = self else {
                    return
                }
                self.storageService.user = UserEntity(email: self.userModel.email, token: response.token)
                self.view?.showSuccess {
                    self.onRequestSuccess?()
                }
            }.onError { [weak self] _ in
                let error = DetailedError(title: L10n.NewPassword.Error.title,
                                          details: L10n.NewPassword.Error.details)
                self?.onErrorOccured?(error)
            }
            .defer { [weak self] in
                self?.view?.hideLoading()
            }
    }

}
