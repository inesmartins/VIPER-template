//
//  CountryPresenter.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

protocol CountryListPresenterDelegate: AnyObject {
    func loadCountryList(inView view: CountryListViewControllerDelegate)
    func didSelectCountry(_ country: Country)
    func didSelectStore(_ store: Store)
    func didClickSaveCountry()
    func didClickLoadSavedCountry()
}

final class CountryListPresenter: CountryListPresenterDelegate {

    private var interactor: CountryListInteractorDelegate?
    private var view: CountryListViewControllerDelegate?
    private var selectedCountry: Country?
    private var selectedStore = Store.allCases[0]

    init(_ interactor: CountryListInteractorDelegate) {
        self.interactor = interactor
    }

    func loadCountryList(inView view: CountryListViewControllerDelegate) {
        self.view = view
        if let countries = self.interactor?.loadCountryList() {
            self.view?.updateCountryList(countries)
        }
    }

    func didSelectCountry(_ country: Country) {
        self.selectedCountry = country
    }

    func didSelectStore(_ store: Store) {
        self.selectedStore = store
    }

    func didClickSaveCountry() {
        if let selectedCountry = self.selectedCountry {
            self.interactor?.storeCountry(onStore: self.selectedStore, selectedCountry, onCompletion: { success in
                self.view?.showSaveResult(success)
            })
        }
    }

    func didClickLoadSavedCountry() {
        self.interactor?.loadStoredCountry(from: self.selectedStore, onCompletion: { country in
            if let country = country {
                self.view?.showSavedCountry(country)
            }
        })
    }

}
