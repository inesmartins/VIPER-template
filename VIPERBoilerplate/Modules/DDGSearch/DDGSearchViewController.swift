import Foundation
import UIKit
import Device
import ToastSwiftFramework

protocol DDGSearchViewControllerDelegate: AnyObject {
    func showResult(_ searchResult: SearchResult)
    func showNoResultsFound()
}

final class DDGSearchViewController: KeyboardAwareViewController {

    // MARK: - UIViewController Properties

    private var presenter: DDGSearchPresenterDelegate?

    // MARK: - UI components

    private lazy var textArea = UITextView(frame: .zero)
    private lazy var searchButton = UIButton(frame: .zero)

    // MARK: - UIViewController Lifecycle

    init(_ presenter: DDGSearchPresenterDelegate) {
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

extension DDGSearchViewController: DDGSearchViewControllerDelegate {

    func showNoResultsFound() {
        self.view.makeToast("No Results Found")
    }

    func showResult(_ searchResult: SearchResult) {
        self.view.makeToast("\(searchResult)")
        // TODO: implement better solution
    }

}

private extension DDGSearchViewController {

    func setupViews() {
        self.addSubviews()
        self.setupUIComponents()
        self.addConstraints()
    }

    func addSubviews() {
        self.view.addSubview(self.textArea)
        self.view.addSubview(self.searchButton)
    }

    func setupUIComponents() {
        self.view.backgroundColor = .white
        self.textArea.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.setTitle("Search on DuckDuckGo", for: .normal)
        self.searchButton.setTitleColor(.red, for: .normal)
    }

    func addConstraints() {
        let constraints = [
            self.textArea.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            self.textArea.heightAnchor.constraint(equalToConstant: 50.0),
            self.textArea.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.textArea.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.searchButton.widthAnchor.constraint(equalToConstant: 150.0),
            self.searchButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.searchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.searchButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
