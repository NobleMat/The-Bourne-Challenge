protocol MovieDetailDisplaying: AnyObject {
    func set(title: String)
}

protocol MovieDetailPresenting {
    func displayDidLoad()
}

final class MovieDetailPresenter {

    // MARK: - Properties

    // MARK: Private

    private weak var display: MovieDetailDisplaying!

    init(
        display: MovieDetailDisplaying
    ) {
        self.display = display
    }
}

// MARK: - Conformance

// MARK: MovieDetailPresenting

extension MovieDetailPresenter: MovieDetailPresenting {

    func displayDidLoad() {
        display.set(title: Strings.title.rawValue)
    }
}

// MARK: Private

private extension MovieDetailPresenter {
    enum Strings: String {
        case title
    }
}
