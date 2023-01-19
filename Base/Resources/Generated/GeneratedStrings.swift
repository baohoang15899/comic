// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Home {
    /// Trang chủ
    internal static let tab = L10n.tr("Localizable", "home.tab", fallback: "Trang chủ")
    internal enum Section {
      /// Localizable.strings
      ///   Base
      /// 
      ///   Created by BaoHoang on 15/10/2022.
      internal static let hot = L10n.tr("Localizable", "home.section.hot", fallback: "Truyện Hot")
      /// Top Ngày
      internal static let topDay = L10n.tr("Localizable", "home.section.topDay", fallback: "Top Ngày")
      /// Top Tháng
      internal static let topMonth = L10n.tr("Localizable", "home.section.topMonth", fallback: "Top Tháng")
      /// Top Tuần
      internal static let topWeek = L10n.tr("Localizable", "home.section.topWeek", fallback: "Top Tuần")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
