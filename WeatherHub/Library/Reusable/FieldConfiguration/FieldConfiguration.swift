//
//  FieldConfiguration.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 25.10.2021.
//

import TextFieldsCatalog
import UIKit

enum FieldConfiguration {

    static var background: BackgroundConfiguration {
        BackgroundConfiguration(color: Asset.Colors.contrastBackground.color)
    }

    static var line: LineConfiguration {
        LineConfiguration(insets: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16),
                          defaultHeight: 1,
                          increasedHeight: 2,
                          cornerRadius: 1,
                          superview: nil,
                          colors: ColorConfiguration(error: Asset.Colors.error.color,
                                                     normal: Asset.Colors.border.color,
                                                     active: Asset.Colors.tint.color,
                                                     disabled: Asset.Colors.border.color))
    }

    static var field: TextFieldConfiguration {
        TextFieldConfiguration(font: UIFont.systemFont(ofSize: 16, weight: .regular),
                               defaultPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                               increasedPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40),
                               tintColor: Asset.Colors.tint.color,
                               colors: ColorConfiguration(error: .label,
                                                          normal: .label,
                                                          active: .label,
                                                          disabled: Asset.Colors.border.color))
    }

    static var configuration: UnderlinedTextFieldConfiguration {
        let config = UnderlinedTextFieldConfiguration()
        config.background = background
        config.line = line
        config.textField = field
        return config
    }

    static var placeholder: FloatingPlaceholderConfiguration {
        FloatingPlaceholderConfiguration(font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                        height: 19,
                                        topInsets: UIEdgeInsets(top: 2, left: 16, bottom: 0, right: 16),
                                        bottomInsets: UIEdgeInsets(top: 23, left: 15, bottom: 0, right: 16),
                                        increasedRightPadding: 70,
                                        smallFontSize: 12,
                                        bigFontSize: 16,
                                        topColors: ColorConfiguration(error: .secondaryLabel,
                                                                      normal: .secondaryLabel,
                                                                      active: Asset.Colors.tint.color,
                                                                      disabled: .secondaryLabel),
                                        bottomColors: ColorConfiguration(error: .label,
                                                                         normal: .label,
                                                                         active: Asset.Colors.tint.color,
                                                                         disabled: .secondaryLabel))
    }

    static var emailValidator: TextFieldValidator {
        TextFieldValidator(minLength: 1,
                           maxLength: 256,
                           regex: "[A-Z0-9a-z._%+\\-]{1,256}@[A-Za-z0-9.\\-]{1,256}\\.[A-Za-z]{2,64}")
    }

    static var codeValidator: TextFieldValidator {
        TextFieldValidator(minLength: 4,
                           maxLength: 10,
                           regex: nil)
    }

    static var passwordValidator: TextFieldValidator {
        TextFieldValidator(minLength: 6,
                           maxLength: 64,
                           regex: nil)
    }

}
