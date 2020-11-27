import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - Properties

    // MARK: IBOutlets

    // MARK: Private

    // MARK: Public

    var presenter: MovieDetailPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(presenter != nil, "MovieDetailPresenter should be present")

        presenter.displayDidLoad()
    }
}

// MARK: - Conformance

// MARK: MovieDetailDisplaying

extension MovieDetailViewController: MovieDetailDisplaying {
    func set(title: String) {
        self.title = title
    }
}
