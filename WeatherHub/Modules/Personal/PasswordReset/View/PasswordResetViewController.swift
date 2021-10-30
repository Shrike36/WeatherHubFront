//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit
import SurfUtils
import TextFieldsCatalog

final class PasswordResetViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var backButton: CommonButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var emailField: UnderlinedTextField!
    @IBOutlet private weak var requestButton: CommonButton!

    // MARK: - Properties

    var output: PasswordResetViewOutput?

    var emailValue: String? {
        guard emailField.validate() else {
            return nil
        }
        return emailField.text
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - PasswordResetViewInput

extension PasswordResetViewController: PasswordResetViewInput {

    func setupInitialState() {
        configureBackground()
        configureBackButton()
        configureTitle()
        configureDetails()
        configureField()
        configureSendButton()
    }

}

// MARK: - UIGestureRecognizerDelegate

extension PasswordResetViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer == navigationController?.interactivePopGestureRecognizer
    }

}

// MARK: - Private Methods

private extension PasswordResetViewController {

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
        titleLabel.text = L10n.ResetPassword.title
    }

    func configureDetails() {
        detailsLabel.textColor = Asset.Colors.action.color
        detailsLabel.numberOfLines = 0
        detailsLabel.text = L10n.ResetPassword.details
    }

    func configureField() {
        emailField.setup(placeholderServices: [FloatingPlaceholderService(configuration: FieldConfiguration.placeholder)])
        emailField.configuration = FieldConfiguration.configuration
        emailField.layer.cornerRadius = 10
        emailField.layer.masksToBounds = true

        emailField.placeholder = L10n.Auth.email
        emailField.field.textContentType = .emailAddress
        emailField.field.keyboardType = .emailAddress
        emailField.validator = FieldConfiguration.emailValidator
    }

    func configureSendButton() {
        requestButton.applyActionStyle()
        requestButton.setTitle(L10n.ResetPassword.send, for: .normal)
    }

}

// MARK: - Actions

private extension PasswordResetViewController {

    @IBAction
    func handleBackPressed() {
        output?.handleBackPressed()
    }

    @IBAction
    func handleSendPressed() {
        output?.handleSendPressed()
        view.endEditing(true)
    }

}
