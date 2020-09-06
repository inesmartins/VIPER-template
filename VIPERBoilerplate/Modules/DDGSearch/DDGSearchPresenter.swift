import Foundation

protocol DDGSearchPresenterDelegate: AnyObject {
    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerDelegate)
}

final class DDGSearchPresenter {

    private var interactor: DDGSearchInteractorDelegate?
    private var view: DDGSearchViewControllerDelegate?

    init(_ interactor: DDGSearchInteractorDelegate) {
        self.interactor = interactor
    }
}

extension DDGSearchPresenter: DDGSearchPresenterDelegate {

    func didClickSearchButton(searchTerm: String, on view: DDGSearchViewControllerDelegate) {
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
