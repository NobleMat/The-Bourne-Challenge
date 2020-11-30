import UIKit

class TestAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TestingViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

private final class TestingViewController: UIViewController {

    private var testLabel: UILabel = {
        let label = UILabel()
        label.text = "Testing..."
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(testLabel)
        testLabel.centerInSuperView(
            size: CGSize(
                width: view.frame.width,
                height: view.frame.height
            )
        )
    }
}

private extension UIView {

    /// Center the view inside the superview
    /// - Parameter size: A custom size for the view
    func centerInSuperView(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }

        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
