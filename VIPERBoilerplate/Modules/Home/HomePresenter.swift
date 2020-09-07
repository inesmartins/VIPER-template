import Foundation

protocol HomePresenterType {}

protocol HomeViewToPresenterDelegate: AnyObject {
    func didClickDeviceInfoButton()
    func didClickCountryListButton()
}

final class HomePresenter {

    private weak var interactorDelegate: HomePresenterToInteractorDelegate?
    private weak var routerDelegate: HomePresenterToRouterDelegate?

    init(interactorDelegate: HomePresenterToInteractorDelegate, routerDelegate: HomePresenterToRouterDelegate) {
        self.routerDelegate = routerDelegate
        self.interactorDelegate = interactorDelegate
    }

}

extension HomePresenter: HomePresenterType {}

extension HomePresenter: HomeViewToPresenterDelegate {

    func didClickDeviceInfoButton() {
        self.routerDelegate?.showDDGSearch()
    }

    func didClickCountryListButton() {
        self.routerDelegate?.showCountryList()
    }

}
