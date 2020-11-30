import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    weak var splitViewDelegate: SplitViewDelegate! {
        return .init()
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let splitVC = splitViewController
        splitViewController.delegate = splitViewDelegate

        let primaryNavigationController = UINavigationController(rootViewController: listViewController)
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        splitVC.viewControllers = [
            primaryNavigationController,
            detailNavigationController,
        ]

        window?.rootViewController = splitVC
        window?.makeKeyAndVisible()
        return true
    }

    private var listViewController: MovieListViewController = {
        let vc = MovieListViewController.fromStoryboard()
        vc.presenter = MovieListPresenter(display: vc)
        return vc
    }()

    private var detailViewController: MovieDetailViewController = {
        let vc = MovieDetailViewController.fromStoryboard()
        vc.presenter = MovieDetailPresenter(display: vc)
        return vc
    }()

    private var splitViewController: UISplitViewController = {
        let splitvc = UISplitViewController()
        splitvc.preferredDisplayMode = .allVisible
        return splitvc
    }()
}
