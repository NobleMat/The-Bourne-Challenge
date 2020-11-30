@testable import TheBourneChallenge
import XCTest

class MovieListPresenterTests: XCTestCase {

    private var presenter: MovieListPresenter!
    private var mockDisplay: MockMovieListDisplay!
    private var mockManager: MockMovieListManager!

    func testDisplayDidLoad() throws {
        configure()

        presenter.displayDidLoad()

        XCTAssertEqual(mockDisplay.setTitleCalledCount, 1)
        XCTAssertEqual(mockDisplay.setTitle, "Movies")
        XCTAssertEqual(mockDisplay.beginRefreshingCalledCount, 1)

        mockManager.fetchMoviesCompletion?(.success(Movies.mock))

        XCTAssertEqual(mockDisplay.endRefreshingCalledCount, 1)

        XCTAssertEqual(mockDisplay.setSectionsCalledCount, 1)
        XCTAssertEqual(mockDisplay.setTitleCalledCount, 2)

        // Sections
        XCTAssertEqual(mockDisplay.setSections.count, 1)
        XCTAssertEqual(mockDisplay.setSections.first?.items.count, 2)

        let firstListItem = try XCTUnwrap(mockDisplay.setSections.first?.items.first as? MovieListItem)
        assertMovieListItem(firstListItem, title: "title", imageHref: "imageHref")

        let secondListItem = try XCTUnwrap(mockDisplay.setSections.first?.items.last as? MovieListItem)
        assertMovieListItem(secondListItem, title: "Second Movie", imageHref: "imageHref")
    }

    func testListAction() throws {
        configure()

        presenter.displayDidLoad()
        mockManager.fetchMoviesCompletion?(.success(Movies.mock))

        let firstListItem = try XCTUnwrap(mockDisplay.setSections.first?.items.first as? MovieListItem)
        firstListItem.action?()

        XCTAssertEqual(mockDisplay.showDetailCalledCount, 1)
        XCTAssertEqual(mockDisplay.showDetail, Movie.mock())
    }

    func testFailure() throws {
        configure()

        presenter.displayDidLoad()

        mockManager.fetchMoviesCompletion?(.failure(MovieManagerError.cannotProcessData))

        XCTAssertEqual(mockDisplay.setSectionsCalledCount, 1)
        XCTAssertEqual(mockDisplay.setSections.count, 1)
        XCTAssertEqual(mockDisplay.setSections.first?.items.count, 1)

        let errorItem = try XCTUnwrap(mockDisplay.setSections.first?.items.first as? NoDataItem)
        XCTAssertEqual(
            errorItem.text,
            "Could not load movie list. Please try again later."
        )
    }
}

private extension MovieListPresenterTests {

    func configure(
        display: MockMovieListDisplay = .init(),
        manager: MockMovieListManager = .init()
    ) {
        mockDisplay = display
        mockManager = manager

        presenter = .init(
            display: mockDisplay,
            manager: mockManager
        )
    }
}

private final class MockMovieListDisplay: MovieListDisplaying {

    private(set) var setTitleCalledCount: Int = 0
    private(set) var setTitle: String?
    func set(title: String) {
        setTitleCalledCount += 1
        setTitle = title
    }

    private(set) var setSectionsCalledCount: Int = 0
    private(set) var setSections: [TableViewSection] = []
    func set(sections: [TableViewSection]) {
        setSectionsCalledCount += 1
        setSections = sections
    }

    private(set) var beginRefreshingCalledCount: Int = 0
    func beginRefreshing() {
        beginRefreshingCalledCount += 1
    }

    private(set) var endRefreshingCalledCount: Int = 0
    func endRefreshing() {
        endRefreshingCalledCount += 1
    }

    private(set) var showDetailCalledCount: Int = 0
    private(set) var showDetail: Movie?
    func show(detail: Movie) {
        showDetailCalledCount += 1
        showDetail = detail
    }
}

private final class MockMovieListManager: MovieManaging {

    private(set) var fetchMoviesCalledCount: Int = 0
    private(set) var fetchMoviesCompletion: ((Result<Movies, MovieManagerError>) -> Void)?
    func fetchMovies(completion: @escaping (Result<Movies, MovieManagerError>) -> Void) {
        fetchMoviesCalledCount += 1
        fetchMoviesCompletion = completion
    }
}
