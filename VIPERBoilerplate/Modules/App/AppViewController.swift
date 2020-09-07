import UIKit

protocol AppViewControllerType: class {
    func updateCurrent(to viewController: UIViewController)
}

class AppViewController: UIViewController {

    private var current: UIViewController?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppViewController: AppViewControllerType {

    func updateCurrent(to viewController: UIViewController) {
          self.addChild(viewController)
              viewController.view.frame = self.view.bounds
              self.view.addSubview(viewController.view)
              viewController.didMove(toParent: self)
              self.current?.willMove(toParent: nil)
              self.current?.view.removeFromSuperview()
              self.current?.removeFromParent()
              self.current = viewController
    }

}
