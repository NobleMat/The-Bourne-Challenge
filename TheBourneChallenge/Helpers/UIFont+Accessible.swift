import UIKit

extension UIFont {

    enum FontString: String {
        case regular = "AvenirNext-Regular"
        case light = "AvenirNext-UltraLight"
        case semiBold = "AvenirNext-DemiBold"

        var name: String {
            return rawValue
        }
    }

    static func regularFont(with size: CGFloat) -> UIFont {
        return UIFont(name: FontString.regular.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func lightFont(with size: CGFloat) -> UIFont {
        return UIFont(name: FontString.light.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func semiBoldFont(with size: CGFloat) -> UIFont {
        return UIFont(name: FontString.semiBold.name, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}

private extension UIFont {

    /// Helper method used to get a scaled font, that will help with accessibility
    /// - Parameters:
    ///   - textStyle: The textStyle that needs to be used when scaling
    ///   - size: The initial size of the font
    /// - Returns: A scaled font that will scale as per the accessibility size
    func scaledFont(using textStyle: UIFont.TextStyle, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: fontName, size: size) else { fatalError() }
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
    }
}

extension UILabel {
    /// Adds accessibility scaling to labels
    /// - Parameters:
    ///   - textStyle: The textStyle that need to be used when scaling
    ///   - isAttributed: If the text contains attributed or not
    func addAccessibility(using textStyle: UIFont.TextStyle, isAttributed: Bool = false) {
        if isAttributed {
            attributedText = attributedText?.resized(using: textStyle)
        } else {
            font = font.scaledFont(using: textStyle, size: font.pointSize)
            adjustsFontForContentSizeCategory = true
        }
    }
}

private extension NSAttributedString {

    /// Scales the font based on the font attributes found in the text
    /// - Parameter textStyle: The textStyle to be used
    /// - Returns: A custom attributedString that contains scaled fonts
    func resized(using textStyle: UIFont.TextStyle) -> NSAttributedString {
        guard let resizedString: NSMutableAttributedString = mutableCopy() as? NSMutableAttributedString else { return self }
        resizedString.beginEditing()
        enumerateAttributes(
            in: NSRange(location: 0, length: resizedString.length),
            options: []
        ) { originalAttributes, range, _ in
            var resizedAttributes = originalAttributes
            guard let originalFont = resizedAttributes[.font] as? UIFont else { return }
            let newFont = originalFont.scaledFont(using: textStyle, size: originalFont.pointSize)
            resizedAttributes[.font] = newFont
            resizedString.setAttributes(resizedAttributes, range: range)
        }
        resizedString.endEditing()
        return resizedString
    }
}
