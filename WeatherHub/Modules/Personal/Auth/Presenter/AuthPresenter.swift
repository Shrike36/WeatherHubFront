//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

final class AuthPresenter: AuthModuleOutput {

    // MARK: - AuthModuleOutput

    var onErrorOccured: Closure<DetailedError>?
    var onAuthSuccess: EmptyClosure?

    // MARK: - Properties

    weak var view: AuthViewInput?

    // MARK: - Private Properties

    private var state: AuthViewController.State = .signIn

    private let authService = AuthService()
    private let storageService = StorageService()

}

// MARK: - AuthModuleInput

extension AuthPresenter: AuthModuleInput {
}

// MARK: - AuthViewOutput

extension AuthPresenter: AuthViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        view?.setState(state, animated: false)
    }

    func performMainAction() {
        switch state {
        case .register:
            register()
        case .signIn:
            signIn()
        }
    }

    func handlePasswordReset() {
    }

    func chooseAnotherAction() {
        state = state == .register ? .signIn : .register
        view?.setState(state, animated: true)
    }

}

// MARK: - Private Methods

private extension AuthPresenter {

    func register() {
        guard let email = view?.emailValue, let password = view?.passwordValue, view?.isPasswordRepeated == true else {
            return
        }
        let authModel = AuthRequestEntity(email: email, password: password)

        view?.showLoading()
        authService.register(user: authModel)
            .onCompleted { [weak self] response in
                self?.storageService.user = UserEntry(email: email, token: response.token)
                self?.onAuthSuccess?()
            }.onError { [weak self] _ in
                let error = DetailedError(title: L10n.Auth.Register.Error.title,
                                          details: L10n.Auth.Register.Error.details)
                self?.onErrorOccured?(error)
            }
            .defer { [weak self] in
                self?.view?.hideLoading()
            }
    }

    func signIn() {
        guard let email = view?.emailValue, let password = view?.passwordValue else {
            return
        }
        let authModel = AuthRequestEntity(email: email, password: password)

        view?.showLoading()
        authService.signIn(user: authModel)
            .onCompleted { [weak self] response in
                self?.storageService.user = UserEntry(email: email, token: response.token)
                self?.onAuthSuccess?()
            }.onError { [weak self] _ in
                let error = DetailedError(title: L10n.Auth.SignIn.Error.title,
                                          details: L10n.Auth.SignIn.Error.details)
                self?.onErrorOccured?(error)
            }
            .defer { [weak self] in
                self?.view?.hideLoading()
            }
    }

}
