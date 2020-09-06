import Foundation

protocol DeviceInfoRouterProtocol: AnyObject {
    func makeDeviceInfo() -> DDGSearchViewController
}

final class DDGSearchRouter {
    
    private let ddgService: DuckDuckGoServiceProtocol

    init(ddgService: DuckDuckGoServiceProtocol) {
        self.ddgService = ddgService
    }
}

extension DDGSearchRouter: DeviceInfoRouterProtocol {

    func makeDeviceInfo() -> DDGSearchViewController {
        let interactor = DDGSearchInteractor(ddgService: self.ddgService)
        let presenter = DDGSearchPresenter(interactor)
        return DDGSearchViewController(presenter)
    }
}
