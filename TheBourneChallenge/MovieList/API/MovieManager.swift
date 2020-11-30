import Alamofire

enum MovieManagerError: Error {
    case cannotProcessData
}

/// A protocol that aids in fetching movies from the backend
protocol MovieManaging {
    func fetchMovies(completion: @escaping (Result<Movies, MovieManagerError>) -> Void)
}

final class MovieManager: MovieManaging {

    private let fetchUrl: String = "https://www.dropbox.com/s/q1ins5dsldsojzt/movies.json?dl=1"

    func fetchMovies(completion: @escaping (Result<Movies, MovieManagerError>) -> Void) {
        AF.request(fetchUrl, method: .get)
            .responseDecodable { (response: DataResponse<Movies, AFError>) in
                if let movieResponse = response.value {
                    completion(.success(movieResponse))
                } else {
                    completion(.failure(.cannotProcessData))
                }
            }
    }
}
