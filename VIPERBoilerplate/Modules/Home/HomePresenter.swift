import Foundation

protocol HomePresenterProtocol: AnyObject {
    func didClickDeviceInfoButton()
    func didClickCountryListButton()
}

final class HomePresenter {

    private var interactor: HomeInteractorProtocol?
    private var router: HomeRouterProtocol?

    init(_ interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

}

extension HomePresenter: HomePresenterProtocol {

    func didClickDeviceInfoButton() {
        self.router?.showDeviceInfo()
    }

    func didClickCountryListButton() {
        self.router?.showCountryList()
    }

}
