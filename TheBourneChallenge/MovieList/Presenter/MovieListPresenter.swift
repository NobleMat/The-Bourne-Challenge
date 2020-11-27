import Foundation

protocol MovieListDisplaying: AnyObject {
    func set(title: String)
}

protocol MovieListPresenting {
    func displayDidLoad()
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
    }
}

// MARK: Private

private extension MovieListPresenter {
    enum Strings: String {
        case title
    }

    func fetchMovies() {
        manager.fetchMovies { result in
            switch result {
            case .success(let movie): break
            case .failure: break
            }
        }
    }
}
