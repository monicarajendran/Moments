//
//  AppColors.swift
//  AWW
//
//  Created by Karthik on 11/3/17.
//  Copyright © 2017 AnywhereWorks. All rights reserved.
//

import Foundation
import UIKit


struct AppFont {
    
    static func regular(size: CGFloat) -> UIFont {
        return FontManager(.installed(.regular), size: .custom(size)).instance
    }
    
    static func dynamicRegular(size: CGFloat, maxSize: CGFloat) -> UIFont {
        let customFont = FontManager(.installed(.regular), size: .custom(size)).instance
         return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    /// Medium
    static func medium(size: CGFloat) -> UIFont {
        return FontManager(.installed(.medium), size: .custom(size)).instance
    }
    
    static func dynamicMedium(size: CGFloat, maxSize: CGFloat = 30) -> UIFont {
        let customFont = FontManager(.installed(.medium), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    static func mediumItalic(size: CGFloat) -> UIFont {
        return FontManager(.installed(.mediumItalic), size: .custom(size)).instance
    }
    
    static func dynamicMediumItalic(size: CGFloat, maxSize: CGFloat = 30) -> UIFont {
        let customFont = FontManager(.installed(.mediumItalic), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    /// Bold
    static func bold(size: CGFloat) -> UIFont {
        return FontManager(.installed(.bold), size: .custom(size)).instance
    }
    
    static func dynamicBold(size: CGFloat, maxSize: CGFloat = 20) -> UIFont {
        let customFont = FontManager(.installed(.bold), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    static func boldItalic(size: CGFloat) -> UIFont {
        return FontManager(.installed(.boldItalic), size: .custom(size)).instance
    }
    
    /// SemiBold
    static func semiBold(size: CGFloat) -> UIFont {
        return FontManager(.installed(.semiBold), size: .custom(size)).instance
    }
    
    static func dynamicSemiBold(size: CGFloat, maxSize: CGFloat) -> UIFont {
        let custom = FontManager(.installed(.semiBold), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: custom, maximumPointSize: maxSize)
    }

    static func semiBoldItalic(size: CGFloat) -> UIFont {
        return FontManager(.installed(.semiboldItalic), size: .custom(size)).instance
    }
    
    static func dynamicSemiBoldItalic(size: CGFloat, maxSize: CGFloat) -> UIFont {
        let customFont = FontManager(.installed(.semiboldItalic), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
    
    static func font(forType type: FontManager.FontStyle, size: CGFloat) -> UIFont {
        return FontManager(.installed(type), size: .custom(size)).instance
    }
    
    static func dynamicFont(forType type: FontManager.FontStyle, size: CGFloat) -> UIFont {
        let customFont = FontManager(.installed(type), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont)
    }
    
    /// Dynamic Font Size with Max font size
    static func dynamicFont(forType type: FontManager.FontStyle, size: CGFloat, maxSize: CGFloat = 34) -> UIFont {
        let customFont = FontManager(.installed(type), size: .custom(size)).instance
        return FontMetrics.scaledFont(for: customFont, maximumPointSize: maxSize)
    }
}



/// A `UIFontMetrics` wrapper, allowing iOS 11 devices to take advantage of `UIFontMetrics` scaling,
/// while earlier iOS versions fall back on a scale calculation.
///
struct FontMetrics {
    
    /// A scale value based on the current device text size setting. With the device using the
    /// default Large setting, `scaler` will be `1.0`. Only used when `UIFontMetrics` is not
    /// available.
    ///
    static var scaler: CGFloat {
        return UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
    }
    
    /// Returns a version of the specified font that adopts the current font metrics.
    ///
    /// - Parameter font: A font at its default point size.
    /// - Returns: The font at its scaled point size.
    ///
    static func scaledFont(for font: UIFont) -> UIFont {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: font)
        } else {
            return font.withSize(scaler * font.pointSize)
        }
    }
    
    /// Returns a version of the specified font that adopts the current font metrics and is
    /// constrained to the specified maximum size.
    ///
    /// - Parameters:
    ///   - font: A font at its default point size.
    ///   - maximumPointSize: The maximum point size to scale up to.
    /// - Returns: The font at its constrained scaled point size.
    ///
    static func scaledFont(for font: UIFont, maximumPointSize: CGFloat) -> UIFont {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: font,
                                                    maximumPointSize: maximumPointSize,
                                                    compatibleWith: nil)
        } else {
            return font.withSize(min(scaler * font.pointSize, maximumPointSize))
        }
    }
    
    /// Scales an arbitrary layout value based on the current Dynamic Type settings.
    ///
    /// - Parameter value: A default size value.
    /// - Returns: The value scaled based on current Dynamic Type settings.
    ///
    static func scaledValue(for value: CGFloat) -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledValue(for: value)
        } else {
            return scaler * value
        }
    }
}
