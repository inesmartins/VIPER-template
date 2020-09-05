import Foundation
import UIKit

protocol AuthenticationViewControllerDelegate: class {
}

final class AuthenticationViewController: UIViewController {

    // MARK: - UIViewController Properties

    private var presenter: AuthenticationPresenter?

    // MARK: - UI components

    private lazy var formContainer = UIView(frame: .zero)
    private lazy var usernameTextField = UITextField(frame: .zero)
    private lazy var passwordTextField = UITextField(frame: .zero)

    // MARK: - UIViewController Lifecycle

    init(presenter: AuthenticationPresenter) {
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
        self.view.addSubview(self.formContainer)
        self.formContainer.addSubview(self.usernameTextField)
        self.formContainer.addSubview(self.passwordTextField)
    }

    private func setupUIComponents() {

        self.formContainer.translatesAutoresizingMaskIntoConstraints = false
        self.formContainer.backgroundColor = .white

        // usernameTextField UITextField
        self.usernameTextField.translatesAutoresizingMaskIntoConstraints = false

        // passwordTextField UITextField
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.formContainer.heightAnchor.constraint(equalToConstant: 100.0),
            self.formContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.formContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.formContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 50.0),
            self.usernameTextField.topAnchor.constraint(equalTo: self.formContainer.topAnchor),
            self.usernameTextField.leadingAnchor.constraint(equalTo: self.formContainer.leadingAnchor),
            self.usernameTextField.trailingAnchor.constraint(equalTo: self.formContainer.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
            self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.formContainer.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.formContainer.trailingAnchor),
            self.passwordTextField.bottomAnchor.constraint(equalTo: self.formContainer.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
