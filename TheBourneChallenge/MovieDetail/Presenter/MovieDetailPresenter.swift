import Foundation

protocol MovieDetailDisplaying: AnyObject {
    func set(title: String)
    func set(title: String, releaseDate: String)
    func set(rating: String)
    func hideRating()
    func set(imageUrl: URL)
    func hideImage()
    func set(error: String)
}

protocol MovieDetailPresenting {
    var hasDetail: Bool { get }
    func displayDidLoad()
    func update(movie: Movie)
}

final class MovieDetailPresenter {

    // MARK: - Properties

    // MARK: Private

    private weak var display: MovieDetailDisplaying!

    // MARK: Public
    var movie: Movie? {
        didSet {
            updateDetail(with: movie)
        }
    }

    init(
        display: MovieDetailDisplaying,
        movie: Movie? = nil
    ) {
        self.display = display
        self.movie = movie
    }
}

// MARK: - Conformance

// MARK: MovieDetailPresenting

extension MovieDetailPresenter: MovieDetailPresenting {

    var hasDetail: Bool {
        return movie != nil
    }

    func displayDidLoad() {
        display.set(title: Strings.title.rawValue)
        updateDetail(with: movie)
    }

    func update(movie: Movie) {
        self.movie = movie
    }
}

// MARK: Private

private extension MovieDetailPresenter {
    enum Strings: String {
        case title = "Movie Detail"
        case error = "Please click on a movie, to see it's details"
        case rating = "Rating: %.2f"
        case releaseDate = "Release Date: %@"
    }

    private func updateDetail(with movie: Movie?) {
        guard let movie = movie else {
            display.set(error: Strings.error.rawValue)
            return
        }
        display.set(title: movie.title)
        let releaseDate = String(format: Strings.releaseDate.rawValue, movie.releaseDate)
        display.set(title: movie.title, releaseDate: releaseDate)

        if let rating = movie.rating {
            let ratingString = String(format: Strings.rating.rawValue, rating)
            display.set(rating: ratingString)
        } else {
            display.hideRating()
        }

        guard
            let imageUrl = movie.imageHref,
            let url = URL(string: imageUrl)
        else {
            display.hideImage()
            return
        }
        display.set(imageUrl: url)
    }
}
