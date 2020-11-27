import UIKit

// MARK: - XIBLodable

protocol XIBLodable: NSObject {
    static var nib: UINib { get }
}

extension UIView: XIBLodable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: nil)
    }

    static var name: String {
        return String(describing: self)
    }
}
