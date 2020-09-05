import Foundation
import UIKit

protocol HomeRouterDelegate: AnyObject {
    func showHome(onRootViewController rootViewController: UINavigationController)
    func showDeviceInfo()
    func showCountryList()
}

final class HomeRouter: HomeRouterDelegate {

    private weak var routerDelegate: AppRouterDelegate?
    private var homeViewController: UIViewController?

    init(routerDelegate: AppRouterDelegate) {
        self.routerDelegate = routerDelegate
    }

    func showHome(onRootViewController rootViewController: UINavigationController) {
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor, routingDelegate: self)
        self.homeViewController = HomeViewController(presenter)
        rootViewController.addChild(self.homeViewController!)
    }

    func showDeviceInfo() {
        let deviceInfoCtrl = DeviceInfoRouter().makeDeviceInfo()
        self.homeViewController?.present(deviceInfoCtrl, animated: true, completion: nil)
    }

    func showCountryList() {
        let countryListCtrl = CountryListRouter().makeCountryList()
        self.homeViewController?.present(countryListCtrl, animated: true, completion: nil)
    }

}
