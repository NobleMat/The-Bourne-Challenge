import UIKit

final class MovieListViewController: UIViewController {

    // MARK: - Properties

    // MARK: IBOutlets

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.registerReusable(
                [
                    MovieListTableViewCell.self,
                    NoDataTableViewCell.self,
                ]
            )
            tableView.tableFooterView = UIView()
            tableView.refreshControl = refreshControl
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }

    // MARK: Private

    private var sections: [TableViewSection] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl.default
        refreshControl.addTarget(self, action: .refresh, for: .valueChanged)
        return refreshControl
    }

    // MARK: Public

    var presenter: MovieListPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(presenter != nil, "MovieListPresenter should be present")

        view.backgroundColor = .viewBackground

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never

        presenter.displayDidLoad()
    }
}

// MARK: - Helpers

// MARK: Private

private extension MovieListViewController {

    @IBAction func didTapRefresh(_ sender: UIBarButtonItem) {
        refresh()
    }

    @objc func refresh() {
        presenter.refreshData()
    }
}

// MARK: - Conformance

// MARK: MovieListDisplaying

extension MovieListViewController: MovieListDisplaying {

    func set(sections: [TableViewSection]) {
        self.sections = sections
    }

    func set(title: String) {
        self.title = title
    }

    func beginRefreshing() {
        tableView.refreshControl?.beginRefreshing()
    }

    func endRefreshing() {
        if tableView.refreshControl?.isRefreshing == true {
            tableView.refreshControl?.endRefreshing()
        }
    }

    func show(detail: Movie) {
        let detailNavigationController: UINavigationController
        let detailViewController: MovieDetailViewController
        if let navigationController = splitViewController?.secondaryViewController as? UINavigationController,
            let viewController = navigationController.topViewController as? MovieDetailViewController {
            detailNavigationController = navigationController
            detailViewController = viewController
            detailViewController.presenter.update(movie: detail)
        } else {
            detailViewController = MovieDetailViewController.fromStoryboard()
            detailViewController.presenter = MovieDetailPresenter(
                display: detailViewController,
                movie: detail
            )
            detailNavigationController = UINavigationController(rootViewController: detailViewController)
        }

        detailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        detailViewController.navigationItem.leftItemsSupplementBackButton = true

        splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
    }
}

// MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section]
            .items[indexPath.row]
            .extractCell(from: tableView, for: indexPath)
    }
}

// MARK: UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section]
            .items[indexPath.row]
            .action?()
    }
}

// MARK: - Selector Helpers

private extension Selector {
    static var refresh = #selector(MovieListViewController.refresh)
}

// MARK: - UISplitViewController Helpers

extension UISplitViewController {

    var secondaryViewController: UIViewController? {
        return viewControllers.count > 1 ? viewControllers[1] : nil
    }
}
