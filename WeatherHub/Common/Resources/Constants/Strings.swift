// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Auth {
    /// E-Mail
    internal static let email = L10n.tr("Localizable", "Auth.email")
    /// Already have an account?
    internal static let hasAccount = L10n.tr("Localizable", "Auth.hasAccount")
    /// Have no account?
    internal static let noAccount = L10n.tr("Localizable", "Auth.noAccount")
    /// Password
    internal static let password = L10n.tr("Localizable", "Auth.password")
    /// Repeat password
    internal static let repeatPassword = L10n.tr("Localizable", "Auth.repeatPassword")
    /// I forgot password
    internal static let resetPassword = L10n.tr("Localizable", "Auth.resetPassword")
    internal enum Register {
      /// Register
      internal static let action = L10n.tr("Localizable", "Auth.register.action")
      /// Registration
      internal static let title = L10n.tr("Localizable", "Auth.register.title")
      internal enum Error {
        /// Maybe account already exists
        internal static let details = L10n.tr("Localizable", "Auth.register.error.details")
        /// Could not register user
        internal static let title = L10n.tr("Localizable", "Auth.register.error.title")
      }
    }
    internal enum SignIn {
      /// Sign In
      internal static let action = L10n.tr("Localizable", "Auth.signIn.action")
      /// Sign In
      internal static let title = L10n.tr("Localizable", "Auth.signIn.title")
      internal enum Error {
        /// Check email and password
        internal static let details = L10n.tr("Localizable", "Auth.signIn.error.details")
        /// Could not sign in
        internal static let title = L10n.tr("Localizable", "Auth.signIn.error.title")
      }
    }
    internal enum Validation {
      /// Passwords do not match
      internal static let passwordsNotMatching = L10n.tr("Localizable", "Auth.validation.passwordsNotMatching")
    }
  }

  internal enum Common {
    /// Aeris
    internal static let aeris = L10n.tr("Localizable", "Common.aeris")
    /// Done!
    internal static let done = L10n.tr("Localizable", "Common.done")
    /// Loading...
    internal static let loading = L10n.tr("Localizable", "Common.loading")
    /// OpenWeatherMap
    internal static let owm = L10n.tr("Localizable", "Common.owm")
    /// Yandex
    internal static let yandex = L10n.tr("Localizable", "Common.yandex")
  }

  internal enum Date {
    /// Today, 
    internal static let today = L10n.tr("Localizable", "Date.today")
    /// Tomorrow, 
    internal static let tomorrow = L10n.tr("Localizable", "Date.tomorrow")
  }

  internal enum Map {
    /// Select
    internal static let select = L10n.tr("Localizable", "Map.select")
  }

  internal enum NewPassword {
    /// Security code
    internal static let code = L10n.tr("Localizable", "NewPassword.code")
    /// New password
    internal static let password = L10n.tr("Localizable", "NewPassword.password")
    /// Repeat password
    internal static let repeatPassword = L10n.tr("Localizable", "NewPassword.repeatPassword")
    /// Set password
    internal static let send = L10n.tr("Localizable", "NewPassword.send")
    /// Set new password
    internal static let title = L10n.tr("Localizable", "NewPassword.title")
    internal enum Error {
      /// Maybe security code is incorrect.
      internal static let details = L10n.tr("Localizable", "NewPassword.error.details")
      /// Could not set password
      internal static let title = L10n.tr("Localizable", "NewPassword.error.title")
    }
  }

  internal enum Places {
    /// Remove
    internal static let remove = L10n.tr("Localizable", "Places.remove")
    /// Saved places
    internal static let title = L10n.tr("Localizable", "Places.title")
    internal enum Error {
      /// Try again or select another place
      internal static let advice = L10n.tr("Localizable", "Places.error.advice")
      /// Could not find data for this place :(
      internal static let title = L10n.tr("Localizable", "Places.error.title")
    }
  }

  internal enum ResetPassword {
    /// We will send you an e-mail with security code needed to reset password
    internal static let details = L10n.tr("Localizable", "ResetPassword.details")
    /// Send code
    internal static let send = L10n.tr("Localizable", "ResetPassword.send")
    /// Reset password
    internal static let title = L10n.tr("Localizable", "ResetPassword.title")
    internal enum Error {
      /// Check email. Maybe this user does not exist.
      internal static let details = L10n.tr("Localizable", "ResetPassword.error.details")
      /// Could not reset password
      internal static let title = L10n.tr("Localizable", "ResetPassword.error.title")
    }
  }

  internal enum Search {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Search.cancel")
    /// Search
    internal static let search = L10n.tr("Localizable", "Search.search")
  }

  internal enum Settings {
    /// User: 
    internal static let account = L10n.tr("Localizable", "Settings.account")
    /// Log out
    internal static let signOut = L10n.tr("Localizable", "Settings.signOut")
    /// Settings
    internal static let title = L10n.tr("Localizable", "Settings.title")
    internal enum Login {
      /// You will be able to synchronize saved places between different devices
      internal static let description = L10n.tr("Localizable", "Settings.login.description")
      /// Sign In
      internal static let title = L10n.tr("Localizable", "Settings.login.title")
    }
  }

  internal enum Tabs {
    /// Places
    internal static let location = L10n.tr("Localizable", "Tabs.location")
    /// More
    internal static let more = L10n.tr("Localizable", "Tabs.more")
    /// Weather
    internal static let weather = L10n.tr("Localizable", "Tabs.weather")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
