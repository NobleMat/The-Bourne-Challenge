import UIKit

extension UIRefreshControl {

    /// A custom themed refresh control
    static var `default`: UIRefreshControl {
        let refreshControl: UIRefreshControl = .init()
        refreshControl.tintColor = .systemTeal
        return refreshControl
    }
}
