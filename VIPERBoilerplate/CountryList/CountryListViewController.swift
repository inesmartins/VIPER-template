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
    private lazy var countriesTable = UITableView(frame: .zero)
    private lazy var storeSelector = UIPickerView(frame: .zero)
    private lazy var saveCountryButton = UIButton(frame: .zero)
    private lazy var getSavedCountryButton = UIButton(frame: .zero)
    
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

        // countriesTable UITableView
        self.countriesTable.translatesAutoresizingMaskIntoConstraints = false
        self.countriesTable.dataSource = self
        self.countriesTable.delegate = self
        self.countriesTable.register(UITableViewCell.self, forCellReuseIdentifier: self.tableCellId)

        // storeSelector UIPickerView
        self.storeSelector.translatesAutoresizingMaskIntoConstraints = false
        self.storeSelector.dataSource = self
        self.storeSelector.delegate = self
        self.storeSelector.backgroundColor = .white

        // saveCountryButton UIButton
        self.saveCountryButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveCountryButton.addTarget(self, action: #selector(self.handleSaveCountryButtonClick), for: .touchUpInside)
        self.saveCountryButton.backgroundColor = .green
        self.saveCountryButton.setTitle("Save Country", for: .normal)
        self.saveCountryButton.setTitleColor(.black, for: .normal)

        // getSavedCountryButton UIButton
        self.getSavedCountryButton.translatesAutoresizingMaskIntoConstraints = false
        self.getSavedCountryButton.addTarget(self, action: #selector(self.handleGetSavedCountryButtonClick), for: .touchUpInside)
        self.getSavedCountryButton.backgroundColor = .gray
        self.getSavedCountryButton.setTitle("Get Saved Country", for: .normal)
        self.getSavedCountryButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func handleSaveCountryButtonClick() {
        self.presenter?.didClickSaveCountry()
    }
    
    @objc func handleGetSavedCountryButtonClick() {
        self.presenter?.didClickLoadSavedCountry()
    }

    private func addSubviews() {
        self.view.addSubview(self.countriesTable)
        self.view.addSubview(self.storeSelector)
        self.view.addSubview(self.saveCountryButton)
        self.view.addSubview(self.getSavedCountryButton)
    }
    
    private func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            self.countriesTable.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.countriesTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.countriesTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.storeSelector.heightAnchor.constraint(equalToConstant: 120.0),
            self.storeSelector.topAnchor.constraint(equalTo: self.countriesTable.bottomAnchor),
            self.storeSelector.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.storeSelector.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.saveCountryButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.saveCountryButton.topAnchor.constraint(equalTo: self.storeSelector.bottomAnchor),
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

extension CountryListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Store.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Store.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.presenter?.didSelectStore(Store.allCases[row])
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
            self.countriesTable.reloadData()
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
