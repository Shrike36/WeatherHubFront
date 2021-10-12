// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Common {
    /// Aeris
    internal static let aeris = L10n.tr("Localizable", "Common.aeris")
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

  internal enum Search {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Search.cancel")
    /// Search
    internal static let search = L10n.tr("Localizable", "Search.search")
  }

  internal enum Settings {
    /// Settings
    internal static let title = L10n.tr("Localizable", "Settings.title")
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
