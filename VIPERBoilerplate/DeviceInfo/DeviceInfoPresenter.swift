import Foundation

protocol DeviceInfoPresenterDelegate: class {
}

final class DeviceInfoPresenter {

    private var interactor: DeviceInfoInteractorDelegate?

    init(_ interactor: DeviceInfoInteractorDelegate) {
        self.interactor = interactor
    }
}

extension DeviceInfoPresenter: DeviceInfoPresenterDelegate {
}
