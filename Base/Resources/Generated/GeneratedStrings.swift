// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Category {
    /// Thể loại
    internal static let title = L10n.tr("Localizable", "Category.title", fallback: "Thể loại")
  }
  internal enum ComicDetail {
    /// Tên tác giả: %@
    internal static func author(_ p1: Any) -> String {
      return L10n.tr("Localizable", "ComicDetail.author", String(describing: p1), fallback: "Tên tác giả: %@")
    }
    /// Yêu thích:
    internal static let favorite = L10n.tr("Localizable", "ComicDetail.favorite", fallback: "Yêu thích:")
    /// Trạng thái: %@
    internal static func status(_ p1: Any) -> String {
      return L10n.tr("Localizable", "ComicDetail.status", String(describing: p1), fallback: "Trạng thái: %@")
    }
    /// Tên truyện: %@
    internal static func title(_ p1: Any) -> String {
      return L10n.tr("Localizable", "ComicDetail.title", String(describing: p1), fallback: "Tên truyện: %@")
    }
    internal enum Btn {
      /// Chọn chất lượng ảnh
      internal static let imgQuality = L10n.tr("Localizable", "ComicDetail.btn.imgQuality", fallback: "Chọn chất lượng ảnh")
    }
    internal enum Quality {
      /// Ảnh chất lượng cao
      internal static let high = L10n.tr("Localizable", "ComicDetail.quality.high", fallback: "Ảnh chất lượng cao")
      /// Ảnh chất lượng cao nhất
      internal static let highest = L10n.tr("Localizable", "ComicDetail.quality.highest", fallback: "Ảnh chất lượng cao nhất")
      /// Ảnh chất lượng thấp
      internal static let low = L10n.tr("Localizable", "ComicDetail.quality.low", fallback: "Ảnh chất lượng thấp")
      /// Ảnh chất lượng thấp nhất
      internal static let lowest = L10n.tr("Localizable", "ComicDetail.quality.lowest", fallback: "Ảnh chất lượng thấp nhất")
      /// Ảnh chất lượng trung bình
      internal static let medium = L10n.tr("Localizable", "ComicDetail.quality.medium", fallback: "Ảnh chất lượng trung bình")
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
  internal enum Common {
    internal enum Tab {
      /// Thể loại
      internal static let category = L10n.tr("Localizable", "Common.tab.category", fallback: "Thể loại")
      /// Yêu thích
      internal static let favorite = L10n.tr("Localizable", "Common.tab.favorite", fallback: "Yêu thích")
      /// Trang chủ
      internal static let home = L10n.tr("Localizable", "Common.tab.home", fallback: "Trang chủ")
      /// Tìm kiếm
      internal static let search = L10n.tr("Localizable", "Common.tab.search", fallback: "Tìm kiếm")
    }
    internal enum Update {
      /// Đang cập nhật
      internal static let empty = L10n.tr("Localizable", "Common.update.empty", fallback: "Đang cập nhật")
    }
  }
  internal enum Search {
    /// Nhập tên truyện tranh
    internal static let placeholder = L10n.tr("Localizable", "Search.placeholder", fallback: "Nhập tên truyện tranh")
    /// Tìm kiếm
    internal static let title = L10n.tr("Localizable", "Search.title", fallback: "Tìm kiếm")
    internal enum Empty {
      /// Vui lòng nhập từ khóa, hoặc tên truyện bạn muốn tìm kiếm.
      internal static let content = L10n.tr("Localizable", "Search.empty.content", fallback: "Vui lòng nhập từ khóa, hoặc tên truyện bạn muốn tìm kiếm.")
      /// Bạn chưa nhập từ khóa tìm kiếm
      internal static let title = L10n.tr("Localizable", "Search.empty.title", fallback: "Bạn chưa nhập từ khóa tìm kiếm")
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
      /// Top manga
      internal static let topManga = L10n.tr("Localizable", "home.section.topManga", fallback: "Top manga")
      /// Top manhua
      internal static let topManhua = L10n.tr("Localizable", "home.section.topManhua", fallback: "Top manhua")
      /// Top manhwa
      internal static let topManhwa = L10n.tr("Localizable", "home.section.topManhwa", fallback: "Top manhwa")
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
