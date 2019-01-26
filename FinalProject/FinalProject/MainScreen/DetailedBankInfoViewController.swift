//
//  DetailedBankInfoViewController.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 12/19/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import Foundation
import UIKit
import RHSideButtons

class DetailedBankInfoViewController: UIViewController {
    var organization: BankModel!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var bankURL: UILabel!
    @IBOutlet weak var bankAddress: UILabel!
    @IBOutlet weak var bankPhoneNumber: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureInterface()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "CurrenciesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CurrenciesTableViewCell")
        tableView.dataSource = self as? UITableViewDataSource
        tableView.rowHeight = 44.0

    }
    
    private func configureInterface() {
        bankURL.text = organization.link
        bankAddress.text = organization.address
        bankPhoneNumber.text = organization.phone
        bankName.text = organization.title
        bankImage.sd_setImage(with: organization.formattedUrl)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrenciesTableViewCell", for: indexPath) as! CurrenciesTableViewCell
        let index = indexPath.row
        return cell
    }
}
