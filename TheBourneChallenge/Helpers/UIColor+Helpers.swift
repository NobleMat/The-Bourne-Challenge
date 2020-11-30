import UIKit

extension UIColor {

    /// The color to be used as the background color of the viewController's view
    static var viewBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGroupedBackground
        } else {
            return UIColor.groupTableViewBackground
        }
    }

    /// The color to be used as the background color of any views in the foreground
    static var cellBackground: UIColor {
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
