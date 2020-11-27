import UIKit

public protocol StoryboardLoadable {
    static func fromStoryboard(with identifier: String?) -> Self
    static func fromStoryboard(named storyboardName: String, with identifier: String?) -> Self
}

extension UIViewController: StoryboardLoadable {}

public extension StoryboardLoadable where Self: UIViewController {

    static func fromStoryboard(with identifier: String? = nil) -> Self {
        let expectedSuffix: String = "ViewController"
        let description: String = String(describing: self)
        guard description.hasSuffix(expectedSuffix) else {
            fatalError("Can't automatically determine the storyboard name for view controller \(description)")
        }
        let storyboardName: String = String(describing: description.dropLast(expectedSuffix.count))
        return fromStoryboard(named: storyboardName, with: identifier)
    }

    static func fromStoryboard(named storyboardName: String, with identifier: String? = nil) -> Self {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController: UIViewController

        if let identifier = identifier {
            viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        } else {
            guard let initialViewController = storyboard.instantiateInitialViewController() else {
                fatalError("No initial view controller for storyboard \(storyboardName)")
            }
            viewController = initialViewController
        }
        guard let typedViewController = viewController as? Self else {
            fatalError("View controller loaded from storyboard \(storyboardName) is not of expected type")
        }
        return typedViewController
    }
}
