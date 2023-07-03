//
//  HomeViewProtocols.swift
//  BankOFListDemoApp
//
//  Created by Juan carlos Mireles on 30/06/23.
//

import Foundation

/// Protocolo de Presenter -> View
protocol HomePresenterProtocolsForDataForListOfBanks: AnyObject {
    func updateViewWithListOfBanks(data: [listOfBanksEntity])
}
/// Protocolos del presenter.
protocol HomeViewPresenterProtocols {
    func getDataForListOfBanks()
}
protocol HomeInteractorProtocls {
    @available(iOS 13.0.0, *)
    func getListOfBank() async -> [listOfBanksEntity]
}
/// protocolos del Router.
protocol HomeViewRouterProtocols {
}

