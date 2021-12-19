import UIKit

protocol INetworkService {
    func loadData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NSObject, INetworkService {
    private let session: URLSession

    
    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }

    func loadData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "https://freecurrencyapi.net/api/v2/latest?apikey=4a16fbf0-5bf6-11ec-a4ff-0dc3c805f898") else { assert(false, "Кривой УРЛ") }

        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    print("[NETWORK] \(response)")

                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
