//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import TextFieldsCatalog
import SurfUtils
import UIKit

final class AuthViewController: UIViewController {

    // MARK: - Nested Types

    enum State {
        case register
        case signIn

        var title: String {
            switch self {
            case .register:
                return L10n.Auth.Register.title
            case .signIn:
                return L10n.Auth.SignIn.title
            }
        }

        var needRepeatPassword: Bool {
            return self == .register
        }

        var canResetPassword: Bool {
            return self == .signIn
        }

        var passwordType: UITextContentType {
            switch self {
            case .register:
                return .newPassword
            case .signIn:
                return .password
            }
        }

        var otherActionQuestion: String {
            switch self {
            case .register:
                return L10n.Auth.hasAccount
            case .signIn:
                return L10n.Auth.noAccount
            }
        }

        var actionTitle: String {
            switch self {
            case .register:
                return L10n.Auth.Register.action
            case .signIn:
                return L10n.Auth.SignIn.action
            }
        }

        var otherActionTitle: String {
            switch self {
            case .register:
                return L10n.Auth.SignIn.action
            case .signIn:
                return L10n.Auth.Register.action
            }
        }

    }

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emailField: UnderlinedTextField!
    @IBOutlet private weak var passwordField: UnderlinedTextField!
    @IBOutlet private weak var repeatPasswordField: UnderlinedTextField!
    @IBOutlet private weak var forgotButton: UIButton!
    @IBOutlet private weak var authButton: CommonButton!
    @IBOutlet private weak var otherActionLabel: UILabel!
    @IBOutlet private weak var otherActionButton: UIButton!

    // MARK: - Properties

    var output: AuthViewOutput?

    var emailValue: String? {
        guard emailField.validate() else {
            return nil
        }
        return emailField.text
    }

    var passwordValue: String? {
        guard passwordField.validate() else {
            return nil
        }
        return passwordField.text
    }

    var isPasswordRepeated: Bool {
        return repeatPasswordField.validate()
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - AuthViewInput

extension AuthViewController: AuthViewInput {

    func setupInitialState() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureBackground()
        configureFields()
        configureForgotButton()
        configureAuthButton()
        configureOtherActionLabel()
        configureOtherActionButton()
    }

    func setState(_ state: State, animated: Bool) {
        titleLabel.text = state.title
        passwordField.field.textContentType = state.passwordType
        authButton.setTitle(state.actionTitle, for: .normal)
        otherActionLabel.text = state.otherActionQuestion
        otherActionButton.setTitle(state.otherActionTitle, for: .normal)

        if animated {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.forgotButton.alpha = state.canResetPassword ? 1 : 0
                self?.forgotButton.isHidden = !state.canResetPassword

                self?.repeatPasswordField.alpha = state.needRepeatPassword ? 1 : 0
                self?.repeatPasswordField.isHidden = !state.needRepeatPassword
            }
        } else {
            forgotButton.isHidden = !state.canResetPassword
            repeatPasswordField.isHidden = !state.needRepeatPassword
        }
    }

}

// MARK: - Private Methods

private extension AuthViewController {

    func configureBackground() {
        view.backgroundColor = Asset.Colors.background.color
    }

    func configureFields() {
        [emailField, passwordField, repeatPasswordField].forEach {
            $0?.setup(placeholderServices: [FloatingPlaceholderService(configuration: FieldConfiguration.placeholder)])
            $0?.configuration = FieldConfiguration.configuration
            $0?.layer.cornerRadius = 10
            $0?.layer.masksToBounds = true
        }

        emailField.placeholder = L10n.Auth.email
        emailField.field.textContentType = .emailAddress
        emailField.field.keyboardType = .emailAddress
        emailField.validator = FieldConfiguration.emailValidator

        passwordField.placeholder = L10n.Auth.password
        passwordField.field.keyboardType = .asciiCapable
        passwordField.field.autocorrectionType = .no
        passwordField.mode = .password(.visibleOnNotEmptyText)
        passwordField.validator = FieldConfiguration.passwordValidator

        repeatPasswordField.placeholder = L10n.Auth.repeatPassword
        repeatPasswordField.field.textContentType = .newPassword
        passwordField.field.keyboardType = .asciiCapable
        repeatPasswordField.mode = .password(.visibleOnNotEmptyText)
        repeatPasswordField.validator = PasswordRepeatValidator(validationLogic: { [weak self] repeatedPassword in
            return self?.passwordField.text == repeatedPassword
        })
    }

    func configureForgotButton() {
        forgotButton.contentHorizontalAlignment = .right
        forgotButton.setTitle(L10n.Auth.resetPassword, for: .normal)
        forgotButton.setTitleColor(Asset.Colors.tint.color, for: .normal)
        forgotButton.setTitleColor(Asset.Colors.tintFaded.color, for: .highlighted)
    }

    func configureAuthButton() {
        authButton.applyActionStyle()
    }

    func configureOtherActionLabel() {
        otherActionLabel.textColor = Asset.Colors.action.color
    }

    func configureOtherActionButton() {
        otherActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        otherActionButton.setTitleColor(Asset.Colors.tint.color, for: .normal)
        otherActionButton.setTitleColor(Asset.Colors.tintFaded.color, for: .highlighted)
    }

}

// MARK: - Actions

private extension AuthViewController {

    @IBAction
    func handleAuthActionPressed() {
        view.endEditing(true)
        output?.performMainAction()
    }

    @IBAction
    func handleResetPasswordPressed() {
        output?.handlePasswordReset()
    }

    @IBAction
    func handleAnotherActionPressed() {
        output?.chooseAnotherAction()
    }

    @IBAction
    func handleClosePressed() {
        dismiss(animated: true)
    }

}
