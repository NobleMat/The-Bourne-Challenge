import Foundation

// MARK: - Movies

struct Movies: Codable {
    let title: String
    let movies: [Movie]
}

// MARK: - Movie

struct Movie: Codable {
    let title: String
    let imageHref: String?
    let rating: Double?
    let releaseDate: String
}
