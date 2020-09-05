import Foundation
import UIKit

protocol DeviceInfoViewControllerDelegate: AnyObject {

}

final class DeviceInfoViewController: UIViewController {

    // MARK: - UIViewController Properties

    private var presenter: DeviceInfoPresenterDelegate?

    // MARK: - UI components

    // MARK: - UIViewController Lifecycle

    init(_ presenter: DeviceInfoPresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
