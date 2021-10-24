//
//  PasswordRepeatValidator.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 24.10.2021.
//

import Foundation
import TextFieldsCatalog

class PasswordRepeatValidator: TextFieldValidation {

    // MARK: - Private Properties

    private var validationLogic: ((String?) -> Bool)

    // MARK: - Initialization

    init(validationLogic: @escaping ((String?) -> Bool)) {
        self.validationLogic = validationLogic
    }

    // MARK: - TextFieldValidation

    func validate(_ text: String?) -> (isValid: Bool, errorMessage: String?) {
        return (validationLogic(text), L10n.Auth.Validation.passwordsNotMatching)
    }

}
