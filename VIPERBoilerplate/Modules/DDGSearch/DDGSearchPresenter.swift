import Foundation

protocol DDGSearchViewToPresenterDelegate: AnyObject {
    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerType)
}

final class DDGSearchPresenter {

    private var interactor: DDGSearchPresenterToInteractorDelegate?
    private var view: DDGSearchViewControllerType?

    init(_ interactor: DDGSearchPresenterToInteractorDelegate) {
        self.interactor = interactor
    }
}

extension DDGSearchPresenter: DDGSearchViewToPresenterDelegate {

    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerType) {
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
