@testable import TheBourneChallenge

extension Movies: Equatable {
    public static func == (lhs: Movies, rhs: Movies) -> Bool {
        return lhs.title == rhs.title &&
            lhs.movies == rhs.movies
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title &&
            lhs.imageHref == rhs.imageHref &&
            lhs.rating == rhs.rating &&
            lhs.releaseDate == rhs.releaseDate
    }
}
