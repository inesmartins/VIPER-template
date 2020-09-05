//
//  HomePresenter.swift
//  VIPERBoilerplate
//
//  Created by Inês Martins on 04/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
    func didClickDeviceInfoButton()
    func didClickCountryListButton()
}

final class HomePresenter: HomePresenterDelegate {

    private var interactor: HomeInteractorDelegate?
    private var routerDelegate: HomeRouterDelegate?

    init(_ interactor: HomeInteractorDelegate, routingDelegate: HomeRouterDelegate) {
        self.interactor = interactor
        self.routerDelegate = routingDelegate
    }

    func didClickDeviceInfoButton() {
        self.routerDelegate?.showDeviceInfo()
    }

    func didClickCountryListButton() {
        self.routerDelegate?.showCountryList()
    }

}
