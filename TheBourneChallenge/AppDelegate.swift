import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Switch initial view
        window = UIWindow(frame: UIScreen.main.bounds)
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [listViewController, detailViewController]
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        return true
    }

    private var listViewController: MovieListViewController = .init()
    private var detailViewController: MovieDetailViewController = .init()
}
