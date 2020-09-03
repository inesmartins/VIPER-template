//
//  CountryPresenter.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

protocol CountryListPresenterDelegate {
    func loadCountryList(inView view: CountryListViewControllerDelegate)
    func didSelectCountry(_ country: Country)
    func didClickSaveCountry()
    func didClickLoadSavedCountry()
}

final class CountryListPresenter: CountryListPresenterDelegate {

    private var interactor: CountryListInteractorDelegate?
    private var view: CountryListViewControllerDelegate? = nil
    private var selectedCountry: Country? = nil

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
    
    func didClickSaveCountry() {
        if let selectedCountry = self.selectedCountry {
            self.interactor?.storeCountry(selectedCountry, onCompletion: { success in
                self.view?.showSaveResult(success)
            })
        }
    }

    func didClickLoadSavedCountry() {
        self.interactor?.loadStoredCountry(onCompletion: { country in
            if let country = country {
                self.view?.showSavedCountry(country)
            }
        })
    }

}
