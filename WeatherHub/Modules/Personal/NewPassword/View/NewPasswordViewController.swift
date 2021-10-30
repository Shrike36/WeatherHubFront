//
//  Copyright © 2021 Surf. All rights reserved.
//

import UIKit
import TextFieldsCatalog
import SurfUtils

final class NewPasswordViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var backButton: CommonButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var codeField: UnderlinedTextField!
    @IBOutlet private weak var passwordField: UnderlinedTextField!
    @IBOutlet private weak var repeatPasswordField: UnderlinedTextField!
    @IBOutlet private weak var sendButton: CommonButton!

    // MARK: - Properties

    var output: NewPasswordViewOutput?

    var codeValue: String? {
        guard codeField.validate() else {
            return nil
        }
        return codeField.text
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

// MARK: - NewPasswordViewInput

extension NewPasswordViewController: NewPasswordViewInput {

    func setupInitialState() {
        configureBackground()
        configureBackButton()
        configureTitle()
        configureFields()
        configureSendButton()
    }

}

// MARK: - UIGestureRecognizerDelegate

extension NewPasswordViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer == navigationController?.interactivePopGestureRecognizer
    }

}

// MARK: - Private Methods

private extension NewPasswordViewController {

    func configureBackground() {
        view.backgroundColor = Asset.Colors.background.color
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    func configureBackButton() {
        backButton.contentVerticalAlignment = .fill
        backButton.contentHorizontalAlignment = .fill
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.setImageForAllState(Asset.Assets.back.image)
        backButton.tintColor = Asset.Colors.contrastAction.color
    }

    func configureTitle() {
        titleLabel.text = L10n.NewPassword.title
    }

    func configureFields() {
        [codeField, passwordField, repeatPasswordField].forEach {
            $0?.setup(placeholderServices: [FloatingPlaceholderService(configuration: FieldConfiguration.placeholder)])
            $0?.configuration = FieldConfiguration.configuration
            $0?.layer.cornerRadius = 10
            $0?.layer.masksToBounds = true
        }

        codeField.placeholder = L10n.NewPassword.code
        codeField.field.textContentType = .oneTimeCode
        codeField.field.keyboardType = .numberPad
        codeField.validator = FieldConfiguration.codeValidator
        codeField.maxLength = 10

        passwordField.placeholder = L10n.NewPassword.password
        passwordField.field.keyboardType = .asciiCapable
        passwordField.field.autocorrectionType = .no
        passwordField.mode = .password(.visibleOnNotEmptyText)
        passwordField.validator = FieldConfiguration.passwordValidator

        repeatPasswordField.placeholder = L10n.NewPassword.repeatPassword
        repeatPasswordField.field.textContentType = .newPassword
        passwordField.field.keyboardType = .asciiCapable
        repeatPasswordField.mode = .password(.visibleOnNotEmptyText)
        repeatPasswordField.validator = PasswordRepeatValidator(validationLogic: { [weak self] repeatedPassword in
            return self?.passwordField.text == repeatedPassword
        })
    }

    func configureSendButton() {
        sendButton.applyActionStyle()
        sendButton.setTitle(L10n.NewPassword.send, for: .normal)
    }

}

// MARK: - Actions

private extension NewPasswordViewController {

    @IBAction
    func handleBackPressed() {
        output?.handleBackPressed()
    }

    @IBAction
    func handleSendPressed() {
        view.endEditing(true)
        output?.handleSendPressed()
    }

}
