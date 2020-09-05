import Foundation

protocol DeviceInfoPresenterDelegate: AnyObject {
}

final class DeviceInfoPresenter: DeviceInfoPresenterDelegate {

    private var interactor: DeviceInfoInteractorDelegate?

    init(_ interactor: DeviceInfoInteractorDelegate) {
        self.interactor = interactor
    }
}
