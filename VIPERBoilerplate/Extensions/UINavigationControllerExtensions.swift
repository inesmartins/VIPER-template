import Foundation
import UIKit

extension UINavigationController {

    func clearViewControllerStack() {
        var navigationArray = self.viewControllers
        navigationArray.remove(at: navigationArray.count - 1)
        self.viewControllers = navigationArray
    }
}
