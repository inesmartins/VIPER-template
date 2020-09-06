import Foundation
import Alamofire

protocol DuckDuckGoServiceDelegate: AnyObject {
    func search(searchParams: SearchParams, onCompletion: @escaping (Result<SearchResult?, Error>) -> Void)
}

final class DuckDuckGoService {

    private let ddgEndpoint = "https://api.duckduckgo.com/"

}

extension DuckDuckGoService: DuckDuckGoServiceDelegate {

    func search(searchParams: SearchParams, onCompletion: @escaping (Result<SearchResult?, Error>) -> Void) {

        let urlString = "\(self.ddgEndpoint)?\(searchParams.buildQuery())"
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded) else {
                onCompletion(.failure(NSError(domain: "Unable to create path", code: 0, userInfo: nil)))
                return
        }
        AF.request(url).response { result in
            if let error = result.error {
                onCompletion(.failure(error))
            } else if let resultData = result.data {
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: resultData)
                    onCompletion(.success(searchResult))
                } catch {
                    onCompletion(.success(nil))
                }
            } else {
                onCompletion(.success(nil))
            }
        }
    }

}
