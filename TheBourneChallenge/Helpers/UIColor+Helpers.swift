import UIKit

extension UIColor {

    static var backgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGroupedBackground
        } else {
            return UIColor.groupTableViewBackground
        }
    }

    static var viewBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                if traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark {
                    return UIColor(white: 0.111, alpha: 1)
                } else {
                    return UIColor.white
                }
            }
        } else {
            return UIColor.white
        }
    }
}
