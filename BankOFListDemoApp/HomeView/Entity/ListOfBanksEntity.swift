//
//  ListOfBanksEntity.swift
//  BankOFListDemoApp
//
//  Created by Juan carlos Mireles on 30/06/23.
//
import Foundation

/// Entidad que representa la lista de bancos disponible.
struct listOfBanksEntity: Decodable {
    var description: String
    var age: Int
    var url: String
    var bankName: String
}
