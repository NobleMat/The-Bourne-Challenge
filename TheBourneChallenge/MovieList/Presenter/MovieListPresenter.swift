import Foundation

protocol MovieListDisplaying: AnyObject {
    func set(title: String)
    func set(sections: [TableViewSection])
    func beginRefreshing()
    func endRefreshing()
}

protocol MovieListPresenting {
    func displayDidLoad()
    func refreshData()
}

final class MovieListPresenter {

    // MARK: - Properties

    // MARK: Private

    private weak var display: MovieListDisplaying!
    private let manager: MovieManaging

    init(
        display: MovieListDisplaying,
        manager: MovieManaging = MovieManager()
    ) {
        self.display = display
        self.manager = manager
    }
}

// MARK: - Conformance

// MARK: MovieListPresenting

extension MovieListPresenter: MovieListPresenting {

    func displayDidLoad() {
        display.set(title: Strings.title.rawValue)
        fetchMovies()
    }

    func refreshData() {
        display.set(sections: [])
        fetchMovies()
    }
}

// MARK: Private

private extension MovieListPresenter {
    enum Strings: String {
        case title = "Movie"
    }

    func fetchMovies() {
        display.beginRefreshing()
        manager.fetchMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie): self.set(movie: movie)
            case .failure: self.setError()
            }
        }
    }

    func set(movie: Movies) {
        print(movie.movies)
        display.set(title: movie.title)
        display.set(
            sections: [
                .init(
                    items: movie.movies.compactMap { MovieListItem(movie: $0) }
                ),
            ]
        )
        display.endRefreshing()
    }

    func setError() {
        display.set(
            sections: [
                .init(
                    items: [
                        NoDataItem(text: ""),
                    ]
                ),
            ]
        )
        display.endRefreshing()
    }
}
