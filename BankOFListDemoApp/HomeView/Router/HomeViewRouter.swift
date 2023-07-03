//
//  HomeViewRouter.swift
//  BankOFListDemoApp
//
//  Created by Juan carlos Mireles on 30/06/23.
//

import Foundation
import UIKit
class HomeViewRouter {
    /// Función para mostrar la vista como vista inicial de la app.
    func showHomeView(window: UIWindow?) {
        let  view = HomeViewController()
        let  interactor = HomeViewInteractor()
        let router = self
        let presenter = HomeViewPresenter(homeInteractor: interactor, homeRouter: router)
        view.presenter = presenter
        presenter.uiForListOfBanks = view
        let navigation = UINavigationController(rootViewController: view)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
extension HomeViewRouter: HomeViewRouterProtocols {
}
