//
//  HomeViewPresenter.swift
//  BankOFListDemoApp
//
//  Created by Juan carlos Mireles on 30/06/23.
//
import Foundation

class HomeViewPresenter {
    var homeInteractor: HomeViewInteractor
    var homeRouter: HomeViewRouter
    init(homeInteractor: HomeViewInteractor, homeRouter: HomeViewRouter) {
        self.homeInteractor = homeInteractor
        self.homeRouter = homeRouter
    }
    weak var uiForListOfBanks: HomePresenterProtocolsForDataForListOfBanks?
    var dataForListOfBanks: [listOfBanksEntity] = []
}

extension HomeViewPresenter : HomeViewPresenterProtocols {
    func getDataForListOfBanks() {
        Task {
            dataForListOfBanks = await homeInteractor.getListOfBank()
            uiForListOfBanks?.updateViewWithListOfBanks(data: dataForListOfBanks)
        }
    }
}
