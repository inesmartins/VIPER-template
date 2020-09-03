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
}

final class CountryListPresenter: CountryListPresenterDelegate {

    private var interactor: CountryListInteractorDelegate?
    private var view: CountryListViewControllerDelegate? = nil

    init(_ interactor: CountryListInteractorDelegate) {
        self.interactor = interactor
    }

    func loadCountryList(inView view: CountryListViewControllerDelegate) {
        self.view = view
        self.interactor?.loadCountryList(onCompletion: { countries in
            if let countries = countries {
                self.view?.updateCountryList(countries)
            }
        })
    }

}
