//
//  ListOfBanksCell.swift
//  BankOFListDemoApp
//
//  Created by Juan carlos Mireles on 30/06/23.
//
import UIKit
import Kingfisher

class ListOfBanksCell: UITableViewCell {
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var iconBank: UIImageView!
    @IBOutlet weak var lblDescriptionBank: UILabel!
    @IBOutlet weak var lblYearOfBank: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconBank.layer.cornerRadius = 10
    }
    /// función de configuración para respuesta de servicio.
    func setupListBankCell(bankName: String, descriptionBank: String, image: String, yearOfBank: String) {
        lblBankName.text = bankName
        lblDescriptionBank.text = descriptionBank
        iconBank.kf.indicatorType = .activity
        iconBank.kf.setImage(with: URL(string: image), placeholder: nil, options: [.transition(.fade(1.7))],completionHandler: nil)
        lblYearOfBank.text = "\(yearOfBank) Años"
    }
    /// función de configuración para respuesta y almacenamiento interno.
    func setupListOfBanksForCoreData(bankName: String, descriptionBank: String, image: Data, yearOfBank: String) {
        lblBankName.text = bankName
        lblDescriptionBank.text = descriptionBank
        lblYearOfBank.text = "\(yearOfBank) Años"
        iconBank.image = UIImage(data: image)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
