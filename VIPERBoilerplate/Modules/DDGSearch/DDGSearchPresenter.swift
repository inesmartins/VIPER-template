import Foundation

protocol DDGSearchPresenterProtocol: AnyObject {
    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerProtocol)
}

final class DDGSearchPresenter {

    private var interactor: DDGSearchInteractorProtocol?
    private var view: DDGSearchViewControllerProtocol?

    init(_ interactor: DDGSearchInteractorProtocol) {
        self.interactor = interactor
    }
}

extension DDGSearchPresenter: DDGSearchPresenterProtocol {

    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerProtocol) {
        self.view = view
        let searchParams = SearchParams(searchTerm: searchTerm)
        self.interactor?.search(searchParams) { result in
            if let searchResult = result {
                self.view?.showResult(searchResult)
            } else {
                self.view?.showNoResultsFound()
            }
        }
    }

}
