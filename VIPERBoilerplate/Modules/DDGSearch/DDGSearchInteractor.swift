import Foundation

protocol DDGSearchInteractorDelegate: AnyObject {
    func search(_ searchParams: SearchParams, onCompletion: @escaping (SearchResult?) -> Void)
}

final class DDGSearchInteractor {

    private let ddgService: DuckDuckGoServiceDelegate

    init(ddgService: DuckDuckGoServiceDelegate) {
        self.ddgService = ddgService
    }
}

extension DDGSearchInteractor: DDGSearchInteractorDelegate {

    func search(_ searchParams: SearchParams, onCompletion: @escaping (SearchResult?) -> Void) {
        self.ddgService.search(searchParams: searchParams) { result in
            do {
                onCompletion(try result.get())
            } catch let error {
                #if DEBUG
                debugPrint(error)
                #endif
                onCompletion(nil)
            }
        }
    }

}
