//
//  CountryListRouter.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

final class CountryListRouter {
    
    func showCountryList() -> CountryListViewController {
        let interactor = CountryListInteractor()
        let presenter = CountryListPresenter(interactor)
        return CountryListViewController(presenter)
    }
}
