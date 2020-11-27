import Alamofire

enum MovieManagerError: Error {
    case cannotProcessData
}

protocol MovieManaging {
    func fetchMovies(completion: @escaping (Result<Movie, MovieManagerError>) -> Void)
}

final class MovieManager: MovieManaging {

    private let fetchUrl: String = "https://www.dropbox.com/s/q1ins5dsldsojzt/movies.json?dl=1"

    func fetchMovies(completion: @escaping (Result<Movie, MovieManagerError>) -> Void) {
        AF.request(fetchUrl, method: .get)
            .responseDecodable { (response: DataResponse<Movie, AFError>) in
                if let movieResponse = response.value {
                    completion(.success(movieResponse))
                } else {
                    completion(.failure(.cannotProcessData))
                }
            }
    }
}
