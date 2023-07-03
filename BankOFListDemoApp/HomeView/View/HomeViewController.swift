//
//  HomeViewController.swift
//  BankOFListDemoApp
//
//  Created by Juan carlos Mireles on 30/06/23.
//
import UIKit
import CoreData

class HomeViewController: UIViewController {
    /// IBOulet que representa la tabla de lista de bancos.
    @IBOutlet fileprivate weak var tableViewListOfBanks: UITableView!
    /// variable de arquitectura Viper.
    var presenter: HomeViewPresenter?
    /// arreglo que contiene el listado de bancos
    var dataForList: [listOfBanksEntity] = []
    /// arreglo que contiene la lista de bancos en almacenamiento en COREDATA.
    var coreDataDataBase: [ListOfBanksCoreData] = []
    /// Placeholder para imagen de banco no disponible.
    let placeHolderImage = UIImage(named: "placeHolderBank")?.pngData()
    /// Singleton de instancia de CoreData.
    let dataManager = CoreDataManager.shareInstance
    /// header de la secciones en la tabla.
    var headerTitle = ["Service","CoreData"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    /// Función principal de configuración de toda la vista.
    private func setupView() {
        title = "Lista de Bancos"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        getDataInLocalStorange()
    }
    /// función que obtiene los datos en servicio y en almacenamiento local Core data.
    func getDataInLocalStorange() {
        dataManager.getAllListOfBanks {
            DispatchQueue.main.async {
                self.coreDataDataBase = self.dataManager.coreDataFileSaved
                self.validateDataInStorange()
                self.tableViewListOfBanks.reloadData()
            }
        }
    }
    /// función que valida si existen datos en almacenamiento interno.
    func validateDataInStorange() {
        if coreDataDataBase.isEmpty {
            presenter?.getDataForListOfBanks()
        }
    }
}
// MARK: - Funciones de coreData.
extension HomeViewController {
    /// Función para guardar un elemento en el listado de banco.
    func saveDataInLocalStorange(bankName: String, descriptionBank: String, age: Int, imageBank: Data) {
        self.dataManager.createElementInListBanks(bankName: bankName, descriptionBank: descriptionBank, age: age, imageBank: imageBank)
    }
    /// función para eliminar un elemento de la lista de bancos en CoreData.
    func deleteElementInLocalStorage(element: ListOfBanksCoreData) {
        dataManager.deleteItemBank(itemBank: element) {
            self.getDataInLocalStorange()
        }
    }
}
//MARK: - configuración y delegados de la tabla.
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    /// función principal de configuración de la tabla.
    func setupTableView() {
        tableViewListOfBanks.dataSource = self
        tableViewListOfBanks.delegate = self
        tableViewListOfBanks.register(UINib(nibName: "ListOfBanksCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataForList.count
        case 1:
            return coreDataDataBase.count
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListOfBanksCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let dataForBanks = dataForList[indexPath.row]
            cell.setupListBankCell(bankName: dataForBanks.bankName , descriptionBank: dataForBanks.description , image: dataForBanks.url , yearOfBank: dataForBanks.age.description)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.saveDataInLocalStorange(bankName: dataForBanks.bankName, descriptionBank: dataForBanks.description, age: dataForBanks.age, imageBank: cell.iconBank.image?.pngData() ?? self.placeHolderImage!)
            }
            return cell
        case 1:
            guard let coreDataCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListOfBanksCell else { return UITableViewCell() }
            let coreDataInfo = coreDataDataBase[indexPath.row]
            coreDataCell.setupListOfBanksForCoreData(bankName: coreDataInfo.bankname ?? "No Disponible", descriptionBank: coreDataInfo.descriptionBank ?? "No Disponible", image: coreDataInfo.image ?? placeHolderImage!, yearOfBank: coreDataInfo.age.description)
            return coreDataCell
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle[section]
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 1 {
            let item = UIContextualAction(style: .destructive, title: "Eliminar") {  (contextualAction, view, boolValue) in
                let item = self.coreDataDataBase[indexPath.row]
                self.deleteElementInLocalStorage(element: item)
            }
            item.image = UIImage(named: "deleteIcon")
            let swipeActions = UISwipeActionsConfiguration(actions: [item])
            return swipeActions
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [])
        return swipeActions
    }
}
//MARK: - protocolo que reciben los datos del presenter.
extension HomeViewController: HomePresenterProtocolsForDataForListOfBanks {
    func updateViewWithListOfBanks(data: [listOfBanksEntity]) {
        DispatchQueue.main.async {
            self.dataForList = data
            self.tableViewListOfBanks.reloadData()
        }
    }
}
