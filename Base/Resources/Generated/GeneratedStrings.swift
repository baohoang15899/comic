// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum ComicDetail {
    /// Tên tác giả: %@
    internal static func author(_ p1: Any) -> String {
      return L10n.tr("Localizable", "ComicDetail.author", String(describing: p1), fallback: "Tên tác giả: %@")
    }
    /// Trạng thái: %@
    internal static func status(_ p1: Any) -> String {
      return L10n.tr("Localizable", "ComicDetail.status", String(describing: p1), fallback: "Trạng thái: %@")
    }
    /// Tên truyện: %@
    internal static func title(_ p1: Any) -> String {
      return L10n.tr("Localizable", "ComicDetail.title", String(describing: p1), fallback: "Tên truyện: %@")
    }
    internal enum Section {
      /// Thể loại
      internal static let category = L10n.tr("Localizable", "ComicDetail.section.category", fallback: "Thể loại")
      /// Danh sách chương
      internal static let chapter = L10n.tr("Localizable", "ComicDetail.section.chapter", fallback: "Danh sách chương")
      /// Nội dung
      internal static let content = L10n.tr("Localizable", "ComicDetail.section.content", fallback: "Nội dung")
    }
  }
  internal enum Home {
    /// Trang chủ
    internal static let tab = L10n.tr("Localizable", "home.tab", fallback: "Trang chủ")
    internal enum Section {
      /// Truyện hot
      internal static let hot = L10n.tr("Localizable", "home.section.hot", fallback: "Truyện hot")
      /// Localizable.strings
      ///   Base
      /// 
      ///   Created by BaoHoang on 15/10/2022.
      internal static let nominate = L10n.tr("Localizable", "home.section.nominate", fallback: "Truyện đề cử")
      /// Top ngày
      internal static let topDay = L10n.tr("Localizable", "home.section.topDay", fallback: "Top ngày")
      /// Top tháng
      internal static let topMonth = L10n.tr("Localizable", "home.section.topMonth", fallback: "Top tháng")
      /// Top tuần
      internal static let topWeek = L10n.tr("Localizable", "home.section.topWeek", fallback: "Top tuần")
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
