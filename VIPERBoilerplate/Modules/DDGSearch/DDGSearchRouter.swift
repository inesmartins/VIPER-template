import Foundation

protocol DeviceInfoRouterDelegate: AnyObject {
    func makeDeviceInfo() -> DDGSearchViewController
}

final class DDGSearchRouter {
    
    private let ddgService: DuckDuckGoServiceDelegate

    init(ddgService: DuckDuckGoServiceDelegate) {
        self.ddgService = ddgService
    }
}

extension DDGSearchRouter: DeviceInfoRouterDelegate {

    func makeDeviceInfo() -> DDGSearchViewController {
        let interactor = DDGSearchInteractor(ddgService: self.ddgService)
        let presenter = DDGSearchPresenter(interactor)
        return DDGSearchViewController(presenter)
    }
}
