//
//  ViewController.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import UIKit

protocol CountryListViewControllerDelegate {
    func updateCountryList(_ countries: [Country])
    func showSaveResult(_ result: Bool)
    func showSavedCountry(_ country: Country)
}

class CountryListViewController: UIViewController {
    
    // MARK: - UIViewController Properties

    private var presenter: CountryListPresenterDelegate?
    private var countries = Array<Country>()

    // MARK: - UI components

    private let tableCellId = "tableCell"
    private let tableView = UITableView(frame: .zero)
    private let saveCountryButton = UIButton(frame: .zero)
    private let getSavedCountryButton = UIButton(frame: .zero)
    
    // MARK: - UIViewController Lifecycle

    init(_ presenter: CountryListPresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.loadCountryList(inView: self)
        self.setupView()
    }
    
    // MARK: - Setup UI Components
    
    private func setupView() {
        self.addSubviews()
        self.setupUIComponents()
        self.addConstraints()
    }
    
    private func setupUIComponents() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.tableCellId)
        self.saveCountryButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveCountryButton.setTitle("Save Country", for: .normal)
        self.saveCountryButton.addTarget(self, action: #selector(self.handleSaveCountryButtonClick), for: .touchUpInside)
        self.getSavedCountryButton.translatesAutoresizingMaskIntoConstraints = false
        self.getSavedCountryButton.setTitle("Get Saved Country", for: .normal)
        self.getSavedCountryButton.addTarget(self, action: #selector(self.handleGetSavedCountryButtonClick), for: .touchUpInside)
    }
    
    @objc func handleSaveCountryButtonClick() {
        self.presenter?.didClickSaveCountry()
    }
    
    @objc func handleGetSavedCountryButtonClick() {
        self.presenter?.didClickLoadSavedCountry()
    }

    private func addSubviews() {
        self.view.addSubview(self.saveCountryButton)
        self.view.addSubview(self.getSavedCountryButton)
        self.view.addSubview(self.tableView)
    }
    
    private func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.saveCountryButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.saveCountryButton.topAnchor.constraint(equalTo: self.tableView.bottomAnchor),
            self.saveCountryButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.saveCountryButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.getSavedCountryButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.getSavedCountryButton.topAnchor.constraint(equalTo: self.saveCountryButton.bottomAnchor),
            self.getSavedCountryButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.getSavedCountryButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.getSavedCountryButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: self.tableCellId)
        let country = self.countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.code
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.countries[indexPath.row]
        self.presenter?.didSelectCountry(country)
    }

}

extension CountryListViewController: CountryListViewControllerDelegate {
    
    func updateCountryList(_ countries: [Country]) {
        self.countries = countries
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showSaveResult(_ result: Bool) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: result ? "Saved" : "Not Saved",
                message: "",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.modalPresentationStyle = .currentContext
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showSavedCountry(_ country: Country) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Saved Country: \(country.name) - \(country.code   )",
                message: "",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.modalPresentationStyle = .currentContext
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
