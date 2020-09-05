import Foundation

protocol DeviceInfoRouterDelegate: class {
    func makeDeviceInfo() -> DeviceInfoViewController
}

final class DeviceInfoRouter: DeviceInfoRouterDelegate {

    func makeDeviceInfo() -> DeviceInfoViewController {
        let interactor = DeviceInfoInteractor()
        let presenter = DeviceInfoPresenter(interactor)
        return DeviceInfoViewController(presenter)
    }
}
