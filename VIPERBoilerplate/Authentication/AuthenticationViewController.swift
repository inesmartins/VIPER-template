import Foundation
import UIKit

protocol AuthenticationViewControllerDelegate: class {
    func showAuthenticationError()
}

final class AuthenticationViewController: UIViewController {

    // MARK: - UIViewController Properties

    private var presenter: AuthenticationPresenter?
    private var username: String?
    private var password: String?

    // MARK: - UI components

    private lazy var titleLabelContainer = UIView(frame: .zero)
    private lazy var titleLabel = UILabel(frame: .zero)
    private lazy var formContainer = UIView(frame: .zero)
    private lazy var usernameTextField = UITextField(frame: .zero)
    private lazy var passwordTextField = UITextField(frame: .zero)
    private lazy var loginButton = UIButton(frame: .zero)

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
        self.view.addSubview(self.titleLabelContainer)
        self.titleLabelContainer.addSubview(self.titleLabel)
        self.view.addSubview(self.formContainer)
        self.formContainer.addSubview(self.usernameTextField)
        self.formContainer.addSubview(self.passwordTextField)
        self.formContainer.addSubview(self.loginButton)
    }

    private func setupUIComponents() {

        self.view.backgroundColor = .white

        self.titleLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "Sign in"
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.systemFont(ofSize: 22.0)

        // formContainer UIView
        self.formContainer.translatesAutoresizingMaskIntoConstraints = false

        // usernameTextField UITextField
        self.usernameTextField.delegate = self
        self.usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.usernameTextField.borderStyle = .roundedRect
        self.usernameTextField.textContentType = .username
        self.usernameTextField.autocapitalizationType = .none

        // passwordTextField UITextField
        self.passwordTextField.delegate = self
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.borderStyle = .roundedRect
        // tries auto-filling password on Associated Domains
        //self.passwordTextField.textContentType = .newPassword
        self.passwordTextField.isSecureTextEntry = true

        // loginButton UIButton
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.setTitleColor(.black, for: .normal)
        self.loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        self.loginButton.addTarget(self, action: #selector(self.handleLoginButton), for: .touchUpInside)
        self.updateLoginButton(enabled: false)
    }

    @objc func handleLoginButton() {
        if let username = self.username, let password = self.password {
            self.presenter?.didClickLoginButton(onView: self, username: username, password: password)
        }
    }

    private func addConstraints() {

        let constraints = [
            self.titleLabelContainer.heightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            self.titleLabelContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.titleLabelContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor),

            self.formContainer.topAnchor.constraint(equalTo: self.titleLabelContainer.bottomAnchor),
            self.formContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.formContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.formContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            self.titleLabel.centerXAnchor.constraint(equalTo: self.titleLabelContainer.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.titleLabelContainer.centerYAnchor),

            self.usernameTextField.heightAnchor.constraint(equalToConstant: 50.0),
            self.usernameTextField.widthAnchor.constraint(equalTo: self.formContainer.widthAnchor, multiplier: 0.8),
            self.usernameTextField.topAnchor.constraint(equalTo: self.formContainer.topAnchor),
            self.usernameTextField.centerXAnchor.constraint(equalTo: self.formContainer.centerXAnchor),

            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
            self.passwordTextField.widthAnchor.constraint(equalTo: self.formContainer.widthAnchor, multiplier: 0.8),
            self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 20.0),
            self.passwordTextField.centerXAnchor.constraint(equalTo: self.formContainer.centerXAnchor),

            self.loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.loginButton.widthAnchor.constraint(equalToConstant: 150.0),
            self.loginButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.loginButton.bottomAnchor.constraint(equalTo: self.formContainer.bottomAnchor, constant: -20.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func updateLoginButton(enabled: Bool) {
        self.loginButton.alpha = enabled ? 1.0 : 0.2
    }

}

extension AuthenticationViewController: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {

        if textField == self.usernameTextField {
            self.username = (string == "" && textField.text?.count == 1) ? nil : textField.text
        } else {
            self.password = (string == "" && textField.text?.count == 1) ? nil : textField.text
        }
        self.updateLoginButton(enabled: self.username != nil && self.password != nil)

        return true
    }
}

extension AuthenticationViewController: AuthenticationViewControllerDelegate {

    func showAuthenticationError() {
        fatalError("Authentication error modal not implemented")
    }

}
