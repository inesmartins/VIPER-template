import Foundation

protocol HomePresenterDelegate: class {
    func didClickDeviceInfoButton()
    func didClickCountryListButton()
}

final class HomePresenter: HomePresenterDelegate {

    private weak var interactor: HomeInteractorDelegate?
    private var router: HomeRouterDelegate?

    init(_ interactor: HomeInteractorDelegate, routerDelegate: HomeRouterDelegate) {
        self.interactor = interactor
        self.router = routerDelegate
    }

    func didClickDeviceInfoButton() {
        self.router?.showDeviceInfo()
    }

    func didClickCountryListButton() {
        self.router?.showCountryList()
    }

}
