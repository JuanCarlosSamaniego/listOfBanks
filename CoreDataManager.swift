//
//  CoreDataManager.swift
//  
//
//  Created by Juan carlos Mireles on 01/07/23.
//
import Foundation
import UIKit

class CoreDataManager {
    /// Singleton para acceder a las funciones definidas de CoreData.
    static let shareInstance = CoreDataManager()
    /// variable contex usada por CoreData.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /// arreglo que guarda el listado de bancos.
    var coreDataFileSaved: [ListOfBanksCoreData] = []
    /// función que permite recuperar los datos almacenados en coreData.
    func getAllListOfBanks(onCompleted : (() -> Void)?) {
        do {
            coreDataFileSaved = try context.fetch(ListOfBanksCoreData.fetchRequest())
            DispatchQueue.main.async {
                onCompleted!()
            }
        } catch {
            print("Errornal recuperar datos.")
        }
    }
    ///  función para crear un nuevo elemento en la lista de bancos disponibles.
    func createElementInListBanks(bankName: String, descriptionBank: String, age: Int, imageBank: Data) {
        let newElement = ListOfBanksCoreData(context: context)
        newElement.bankname = bankName
        newElement.descriptionBank = descriptionBank
        newElement.age = Int16(age)
        newElement.image = imageBank
        do {
            try context.save()
            print("Elemento Guardado.")
        } catch {
            print("Error:",error.localizedDescription)
        }
    }
    /// función para eliminar un elemento de la lista de bancos almacenados en CoreData.
    func deleteItemBank(itemBank: ListOfBanksCoreData, onCompleted : (() -> Void)?) {
        context.delete(itemBank)
        do {
            try context.save()
            DispatchQueue.main.async {
                onCompleted!()
            }
        } catch {
            print("Error al eliminar.")
        }
    }
}
