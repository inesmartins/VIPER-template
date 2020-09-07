import Foundation

protocol DDGSearchViewToPresenterType: AnyObject {
    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerType)
}

final class DDGSearchPresenter {

    private weak var interactorDelegate: DDGSearchPresenterToInteractorDelegate?
    private weak var view: DDGSearchViewControllerType?

    init(_ interactorDelegate: DDGSearchPresenterToInteractorDelegate) {
        self.interactorDelegate = interactorDelegate
    }
}

extension DDGSearchPresenter: DDGSearchViewToPresenterType {

    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerType) {
        self.view = view
        let searchParams = SearchParams(searchTerm: searchTerm)
        self.interactorDelegate?.search(searchParams) { result in
            if let searchResult = result {
                self.view?.showResult(searchResult)
            } else {
                self.view?.showNoResultsFound()
            }
        }
    }

}
