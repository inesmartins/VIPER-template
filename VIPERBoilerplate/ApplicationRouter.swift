//
//  ApplicationRouter.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import UIKit
import Foundation

final class ApplicationRouter {

    private let window: UIWindow
    private let countryListRouter: CountryListRouter

    init(window: UIWindow) {
        self.countryListRouter = CountryListRouter()
        self.window = window
    }

    func launchApplication() {
        self.window.rootViewController = self.getInitialViewController()
        self.window.makeKeyAndVisible()
    }

    func getInitialViewController() -> CountryListViewController {
        return self.countryListRouter.showCountryList()
    }

}
