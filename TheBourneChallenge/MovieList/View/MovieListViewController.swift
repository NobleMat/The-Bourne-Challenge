import UIKit

final class MovieListViewController: UIViewController {

    // MARK: - Properties

    // MARK: IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: Private

    // MARK: Public

    var presenter: MovieListPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(presenter != nil, "MovieListPresenter should be present")

        presenter.displayDidLoad()
    }
}

// MARK: - Conformance

// MARK: MovieListDisplaying

extension MovieListViewController: MovieListDisplaying {
    func set(title: String) {
        self.title = title
    }
}

// MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
