import Foundation

protocol HomePresenterDelegate: AnyObject {
    func didClickDeviceInfoButton()
    func didClickCountryListButton()
}

final class HomePresenter {

    private var interactor: HomeInteractorDelegate?
    private var router: HomeRouterDelegate?

    init(_ interactor: HomeInteractorDelegate, router: HomeRouterDelegate) {
        self.interactor = interactor
        self.router = router
    }

}

extension HomePresenter: HomePresenterDelegate {

    func didClickDeviceInfoButton() {
        self.router?.showDeviceInfo()
    }

    func didClickCountryListButton() {
        self.router?.showCountryList()
    }

}
