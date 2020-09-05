import Foundation

protocol DeviceInfoPresenterDelegate: class {
}

final class DeviceInfoPresenter: DeviceInfoPresenterDelegate {

    private var interactor: DeviceInfoInteractorDelegate?

    init(_ interactor: DeviceInfoInteractorDelegate) {
        self.interactor = interactor
    }
}
