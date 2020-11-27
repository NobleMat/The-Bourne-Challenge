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

        view.backgroundColor = .backgroundColor

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
    
    
}

// MARK: Selector
private extension Selector {
    static var refresh = #selector(MovieListViewController.refresh)
}
