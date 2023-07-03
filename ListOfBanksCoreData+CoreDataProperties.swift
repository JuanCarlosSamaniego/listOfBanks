//
//  ListOfBanksCoreData+CoreDataProperties.swift
//  
//
//  Created by Juan carlos Mireles on 01/07/23.
//
//
import Foundation
import CoreData

extension ListOfBanksCoreData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListOfBanksCoreData> {
        return NSFetchRequest<ListOfBanksCoreData>(entityName: "ListOfBanksCoreData")
    }
    @NSManaged public var bankname: String?
    @NSManaged public var descriptionBank: String?
    @NSManaged public var age: Int16
    @NSManaged public var image: Data?
}
