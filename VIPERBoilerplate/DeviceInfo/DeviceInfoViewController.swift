import Foundation
import UIKit
import Device

protocol DeviceInfoViewControllerDelegate: class {
}

final class DeviceInfoViewController: UIViewController {

    // MARK: - UIViewController Properties

    private var presenter: DeviceInfoPresenterDelegate?

    // MARK: - UI components

    private lazy var textArea = UITextView(frame: .zero)

    // MARK: - UIViewController Lifecycle

    init(_ presenter: DeviceInfoPresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

}

extension DeviceInfoViewController: DeviceInfoViewControllerDelegate {
}

private extension DeviceInfoViewController {

    func setupViews() {
        self.addSubviews()
        self.setupUIComponents()
        self.addConstraints()
    }

    func addSubviews() {
        self.view.addSubview(self.textArea)
    }

    func setupUIComponents() {
        self.textArea.translatesAutoresizingMaskIntoConstraints = false
        self.textArea.text = "Version: \(Device.version())\nType: \(Device.type())"
    }

    func addConstraints() {
        let constraints = [
            self.textArea.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.textArea.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textArea.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.textArea.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
