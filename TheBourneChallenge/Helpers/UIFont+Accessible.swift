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

    func scaledFont(using textStyle: UIFont.TextStyle, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: fontName, size: size) else { fatalError() }
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
    }
}

extension UILabel {
    func addAccessibility(using textStyle: UIFont.TextStyle, isAttributed: Bool = false) {
        if isAttributed {
            attributedText = attributedText?.resized(using: textStyle)
        } else {
            font = font.scaledFont(using: textStyle, size: font.pointSize)
            adjustsFontForContentSizeCategory = true
        }
    }
}

extension UITextView {
    func addAccessibility(using textStyle: UIFont.TextStyle, isAttributed: Bool = false) {
        if isAttributed {
            attributedText = attributedText?.resized(using: textStyle)
        } else {
            font = font?.scaledFont(using: textStyle, size: font?.pointSize ?? UIFont.labelFontSize)
            adjustsFontForContentSizeCategory = true
        }
    }
}

extension UITextField {
    func addAccessibility(using textStyle: UIFont.TextStyle) {
        font = font?.scaledFont(using: textStyle, size: font?.pointSize ?? UIFont.labelFontSize)
        adjustsFontForContentSizeCategory = true
    }
}

private extension NSAttributedString {
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
