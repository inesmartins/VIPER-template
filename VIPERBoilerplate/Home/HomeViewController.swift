import Foundation
import UIKit

protocol HomeViewControllerDelegate: AnyObject {

}

final class HomeViewController: UIViewController {

    // MARK: - UIViewController Properties

    private var presenter: HomePresenterDelegate?

    // MARK: - UI components

    private lazy var buttonsContainer = UIView(frame: .zero)
    private lazy var deviceInfoButton = UIButton(frame: .zero)
    private lazy var countryListButton = UIButton(frame: .zero)

    // MARK: - UIViewController Lifecycle

    init(_ presenter: HomePresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    // MARK: - Setup UI Components

    private func setupView() {
        self.addSubviews()
        self.setupUIComponents()
        self.addConstraints()
    }

    private func addSubviews() {
        self.view.addSubview(self.buttonsContainer)
        self.buttonsContainer.addSubview(self.deviceInfoButton)
        self.buttonsContainer.addSubview(self.countryListButton)
    }

    private func setupUIComponents() {

        self.buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.buttonsContainer.backgroundColor = .white

        // deviceInfoButton UIButton
        self.deviceInfoButton.translatesAutoresizingMaskIntoConstraints = false
        self.deviceInfoButton.addTarget(self,
                                        action: #selector(self.handleDeviceInfoButtonClick),
                                        for: .touchUpInside)
        self.deviceInfoButton.backgroundColor = .gray
        self.deviceInfoButton.setTitle("See Device Info", for: .normal)
        self.deviceInfoButton.backgroundColor = .white
        self.deviceInfoButton.setTitleColor(.black, for: .normal)

        // deviceInfoButton UIButton
        self.countryListButton.translatesAutoresizingMaskIntoConstraints = false
        self.countryListButton.addTarget(self,
                                         action: #selector(self.handleCountryListButtonClick),
                                         for: .touchUpInside)
        self.countryListButton.backgroundColor = .white
        self.countryListButton.setTitle("See Country List", for: .normal)
        self.countryListButton.setTitleColor(.black, for: .normal)

    }

    private func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.buttonsContainer.heightAnchor.constraint(equalToConstant: 100.0),
            self.buttonsContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.buttonsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.buttonsContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.deviceInfoButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.deviceInfoButton.topAnchor.constraint(equalTo: self.buttonsContainer.topAnchor),
            self.deviceInfoButton.leadingAnchor.constraint(equalTo: self.buttonsContainer.leadingAnchor),
            self.deviceInfoButton.trailingAnchor.constraint(equalTo: self.buttonsContainer.trailingAnchor),
            self.countryListButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.countryListButton.topAnchor.constraint(equalTo: self.deviceInfoButton.bottomAnchor),
            self.countryListButton.leadingAnchor.constraint(equalTo: self.buttonsContainer.leadingAnchor),
            self.countryListButton.trailingAnchor.constraint(equalTo: self.buttonsContainer.trailingAnchor),
            self.countryListButton.bottomAnchor.constraint(equalTo: self.buttonsContainer.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc func handleDeviceInfoButtonClick() {
        self.presenter?.didClickDeviceInfoButton()
    }

    @objc func handleCountryListButtonClick() {
        self.presenter?.didClickCountryListButton()
    }
}
