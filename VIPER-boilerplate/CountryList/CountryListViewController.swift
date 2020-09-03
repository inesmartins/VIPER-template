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
}

class CountryListViewController: UITableViewController {

    private static let tableCellId = "tableCell"
    private var presenter: CountryListPresenterDelegate?
    private var countries = Array<Country>()
    
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
        self.setupTable()
    }
}

extension CountryListViewController {

    private func setupTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CountryListViewController.tableCellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: CountryListViewController.tableCellId)
        let country = self.countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.code
        return cell
    }

}

extension CountryListViewController: CountryListViewControllerDelegate {

    func updateCountryList(_ countries: [Country]) {
        self.countries = countries
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
