@testable import TheBourneChallenge

extension Movies {

    static var mock: Movies {
        return .init(
            title: "Movies",
            movies: [
                .mock(),
                .mock(title: "Second Movie"),
            ]
        )
    }
}

extension Movie {

    static func mock(
        title: String = "title",
        imageHref: String? = "imageHref",
        rating: Double? = 8,
        releaseDate: String = "releaseDate"
    ) -> Movie {
        return .init(
            title: title,
            imageHref: imageHref,
            rating: rating,
            releaseDate: releaseDate
        )
    }
}
