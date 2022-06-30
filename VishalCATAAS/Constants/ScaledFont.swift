//
//  ScaledFont.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//


import SwiftUI

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat
    var color: Color?

    @ViewBuilder func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)

        if let color = color {
            content
                .font(.custom(name, size: scaledSize))
                .foregroundColor(color)
        } else {
            content
                .font(.custom(name, size: scaledSize))
        }
    }
}

enum ScaledFontType: String {
    // https://fonts.google.com/specimen/PT+Sans
    case ptSansRegular = "PTSans-Regular"
    case ptSansItalic = "PTSans-Italic"
    case ptSansBold = "PTSans-Bold"

    // https://fonts.google.com/specimen/Open+Sans
    case openSansRegular = "OpenSans-Regular"
    case openSansSemiBold = "OpenSans-Semibold"
    case openSansBold = "OpenSans-Bold"
}

extension View {
    func scaledFont(type: ScaledFontType = .ptSansRegular, size: CGFloat = 17, color: Color? = nil) -> some View {
        modifier(ScaledFont(name: type.rawValue, size: size, color: color))
    }
}

extension UIFont {
    static func scaledFont(type: ScaledFontType = .ptSansRegular, size: CGFloat = 17) -> UIFont {
        let font = UIFont(name: type.rawValue, size: size) ?? .systemFont(ofSize: size)
        return UIFontMetrics.default.scaledFont(for: font)
    }
}

