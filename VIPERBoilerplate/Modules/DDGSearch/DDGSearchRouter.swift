import Foundation

protocol DDGSearchRouterType: AnyObject {
    func startModule()
}

final class DDGSearchRouter {
    
    private weak var appViewController: AppViewControllerType?
    private weak var ddgService: DDGServiceType?
    private weak var delegate: DDGSearchRouterToHomeRouterDelegate?

    init(appViewController: AppViewControllerType, ddgService: DDGServiceType, delegate: DDGSearchRouterToHomeRouterDelegate) {
        self.appViewController = appViewController
        self.ddgService = ddgService
        self.delegate = delegate
    }
}

extension DDGSearchRouter: DDGSearchRouterType {

    func startModule() {
        guard let ddgService = self.ddgService else {
            assertionFailure("ddgService should be present in DDGSearchRouter")
            return
        }
        let ddgView = self.makeDDGSearchView(ddgService: ddgService)
        self.appViewController?.updateCurrent(to: ddgView)
    }
    
}

private extension DDGSearchRouter {

    func makeDDGSearchView(ddgService: DDGServiceType) -> DDGSearchViewController {
        let interactor = DDGSearchInteractor(ddgService: ddgService)
        let presenter = DDGSearchPresenter(interactor)
        return DDGSearchViewController(presenter)
    }
}
