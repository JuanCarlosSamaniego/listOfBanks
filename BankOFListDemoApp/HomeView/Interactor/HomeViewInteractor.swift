//
//  HomeViewInteractor.swift
//  BankOFListDemoApp
//
//  Created by Juan carlos Mireles on 30/06/23.
//

import Foundation

class HomeViewInteractor {
    let baseURL = "https://dev.obtenmas.com/catom/api/challenge/banks"
}
extension HomeViewInteractor: HomeInteractorProtocls {
    /// función para obtener la lista de bancos disponibles.
    func getListOfBank() async -> [listOfBanksEntity] {
        let url = URL(string: baseURL)!
        let (data,_) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode([listOfBanksEntity].self, from: data)
    }
}
