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

        let requestURL = "\(self.ddgEndpoint)?\(searchParams.buildQuery())"
        AF.request(requestURL).response { result in
            if let error = result.error {
                onCompletion(.failure(error))
                return
            }
            onCompletion(.success(result.data?.to(type: SearchResult.self)))
        }
    }

}
