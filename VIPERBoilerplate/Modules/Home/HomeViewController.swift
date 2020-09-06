import Foundation
import UIKit

protocol HomeViewControllerProtocol: AnyObject {
}

final class HomeViewController: UIViewController {

    // MARK: - UIViewController Properties

    private var presenter: HomePresenterProtocol?

    // MARK: - UI components

    private lazy var buttonsContainer = UIView(frame: .zero)
    private lazy var deviceInfoButton = UIButton(frame: .zero)
    private lazy var countryListButton = UIButton(frame: .zero)

    // MARK: - UIViewController Lifecycle

    init(_ presenter: HomePresenterProtocol) {
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
}

extension HomeViewController: HomeViewControllerProtocol {
}

private extension HomeViewController {

    func setupView() {
        self.addSubviews()
        self.setupUIComponents()
        self.addConstraints()
    }

    func addSubviews() {
        self.view.addSubview(self.buttonsContainer)
        self.buttonsContainer.addSubview(self.deviceInfoButton)
        self.buttonsContainer.addSubview(self.countryListButton)
    }

    func setupUIComponents() {

        self.view.backgroundColor = .white

        self.buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        self.buttonsContainer.backgroundColor = .white

        self.deviceInfoButton.translatesAutoresizingMaskIntoConstraints = false
        self.deviceInfoButton.addTarget(self,
                                        action: #selector(self.handleDeviceInfoButtonClick),
                                        for: .touchUpInside)
        self.deviceInfoButton.setTitle("Search on DuckDuckGo", for: .normal)
        self.deviceInfoButton.setTitleColor(.black, for: .normal)
        self.deviceInfoButton.layer.borderColor = UIColor.black.cgColor
        self.deviceInfoButton.layer.cornerRadius = 7
        self.deviceInfoButton.layer.borderWidth = 2

        self.countryListButton.translatesAutoresizingMaskIntoConstraints = false
        self.countryListButton.addTarget(self,
                                         action: #selector(self.handleCountryListButtonClick),
                                         for: .touchUpInside)
        self.countryListButton.setTitle("See Country List", for: .normal)
        self.countryListButton.setTitleColor(.black, for: .normal)
        self.countryListButton.layer.borderColor = UIColor.black.cgColor
        self.countryListButton.layer.cornerRadius = 7
        self.countryListButton.layer.borderWidth = 2

    }

    func addConstraints() {
        let constraints: [NSLayoutConstraint] = [

            self.buttonsContainer.heightAnchor.constraint(equalToConstant: 120.0),
            self.buttonsContainer.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.buttonsContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            self.buttonsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),

            self.deviceInfoButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.deviceInfoButton.topAnchor.constraint(equalTo: self.buttonsContainer.topAnchor),
            self.deviceInfoButton.leadingAnchor.constraint(equalTo: self.buttonsContainer.leadingAnchor),
            self.deviceInfoButton.trailingAnchor.constraint(equalTo: self.buttonsContainer.trailingAnchor),

            self.countryListButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.countryListButton.topAnchor.constraint(equalTo: self.deviceInfoButton.bottomAnchor, constant: 20.0),
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
