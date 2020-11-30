@testable import TheBourneChallenge
import XCTest

class MovieDetailPresenterTests: XCTestCase {

    private var presenter: MovieDetailPresenter!
    private var mockDisplay: MockMovieDetailDisplay!

    func testDisplayDidLoad() {
        configure()

        presenter.displayDidLoad()

        XCTAssertEqual(mockDisplay.setTitleCalledCount, 2)
        XCTAssertEqual(mockDisplay.setTitle, "title")

        XCTAssertEqual(mockDisplay.setTitleReleaseDateCalledCount, 1)
        XCTAssertEqual(mockDisplay.setTitleReleaseDateTitle, "title")
        XCTAssertEqual(mockDisplay.setReleaseDate, "Release Date: releaseDate")

        XCTAssertEqual(mockDisplay.setRatingCalledCount, 1)
        XCTAssertEqual(mockDisplay.setRating, "Rating: 8.00")

        XCTAssertEqual(mockDisplay.setImageUrlCalledCount, 1)
        XCTAssertEqual(mockDisplay.setImageUrl, URL(string: "imageHref"))
    }

    func testHasDetail() {
        configure(movie: nil)

        XCTAssertFalse(presenter.hasDetail)

        configure()

        XCTAssertTrue(presenter.hasDetail)
    }

    func testInitialDisplay() {
        configure(movie: nil)

        presenter.displayDidLoad()

        XCTAssertEqual(mockDisplay.setErrorCalledCount, 1)
        XCTAssertEqual(mockDisplay.setError, "Please click on a movie, to see it's details")
    }

    func testNilRating() {
        configure(movie: Movie.mock(rating: nil))

        presenter.displayDidLoad()

        XCTAssertEqual(mockDisplay.hideRatingCalledCount, 1)
    }

    func testNilImage() {
        configure(movie: Movie.mock(imageHref: nil))

        presenter.displayDidLoad()

        XCTAssertEqual(mockDisplay.hideImageCalledCount, 1)
    }
}

private extension MovieDetailPresenterTests {

    func configure(
        display: MockMovieDetailDisplay = .init(),
        movie: Movie? = .mock()
    ) {
        mockDisplay = display
        presenter = .init(
            display: mockDisplay,
            movie: movie
        )
    }
}

private final class MockMovieDetailDisplay: MovieDetailDisplaying {

    private(set) var setTitleCalledCount: Int = 0
    private(set) var setTitle: String?
    func set(title: String) {
        setTitleCalledCount += 1
        setTitle = title
    }

    private(set) var setTitleReleaseDateCalledCount: Int = 0
    private(set) var setTitleReleaseDateTitle: String?
    private(set) var setReleaseDate: String?
    func set(title: String, releaseDate: String) {
        setTitleReleaseDateCalledCount += 1
        setTitleReleaseDateTitle = title
        setReleaseDate = releaseDate
    }

    private(set) var setRatingCalledCount: Int = 0
    private(set) var setRating: String?
    func set(rating: String) {
        setRatingCalledCount += 1
        setRating = rating
    }

    private(set) var hideRatingCalledCount: Int = 0
    func hideRating() {
        hideRatingCalledCount += 1
    }

    private(set) var setImageUrlCalledCount: Int = 0
    private(set) var setImageUrl: URL?
    func set(imageUrl: URL) {
        setImageUrlCalledCount += 1
        setImageUrl = imageUrl
    }

    private(set) var hideImageCalledCount: Int = 0
    func hideImage() {
        hideImageCalledCount += 1
    }

    private(set) var setErrorCalledCount: Int = 0
    private(set) var setError: String?
    func set(error: String) {
        setErrorCalledCount += 1
        setError = error
    }
}
