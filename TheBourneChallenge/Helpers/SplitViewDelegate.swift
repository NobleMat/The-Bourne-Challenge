import UIKit

/// Custom class used to set the splitView delegate
final class SplitViewDelegate: NSObject, UISplitViewControllerDelegate {

    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        guard
            let secondaryNavigationController = secondaryViewController as? UINavigationController,
            let movieDetailViewController = secondaryNavigationController.topViewController as? MovieDetailViewController
        else {
            return false
        }
        if !movieDetailViewController.presenter.hasDetail {
            return true
        }
        return false
    }
}
