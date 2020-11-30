@testable import TheBourneChallenge
import XCTest

extension XCTest {

    func assertMovieListItem(
        _ item: MovieListItem,
        title: String,
        imageHref: String
    ) {
        XCTAssertEqual(item.name, title)
        XCTAssertEqual(item.imageUrl, imageHref)
    }
}
