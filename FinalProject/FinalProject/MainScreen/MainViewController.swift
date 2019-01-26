//
//  MainViewController.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 11/26/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var fullInfo: FullInfo?
    var organizations = [BankModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        NetworkManager.sharedInstance.getBankDetails { (fullInfo, error) in
            self.fullInfo = fullInfo
            if let info = fullInfo {
                self.updateOrganizations(allOrganizations: info.organizations)
            }
        }
    }
    
    private func detailsActionInItemAtIndex(_ index: Int) {
        let organization = organizations[index]
        showItemDetailsViewController(organization: organization)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "BankInfoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BankInfoTableViewCell")
        tableView.dataSource = self
        tableView.rowHeight = 180.0
    }
    
    private func showItemDetailsViewController(organization: BankModel) {
        let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let bankDetails = storyboard.instantiateViewController(withIdentifier: "DetailedBankInfoViewController") as! DetailedBankInfoViewController
        bankDetails.organization = organization
        navigationController?.pushViewController(bankDetails, animated: true)
}
    
    private func updateOrganizations(allOrganizations: [BankModel]) {
        organizations = allOrganizations.filter({ (bankInfo) -> Bool in
            return bankInfo.orgType == 1
        })
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankInfoTableViewCell", for: indexPath) as! BankInfoTableViewCell
        let index = indexPath.row
        let organization = organizations[index]
        cell.bankImageView.sd_setImage(with: organization.formattedUrl)
        cell.titleLabel.text = organization.title
        cell.regionLabel.text = fullInfo?.getRegionById(organization.regionId)
        cell.cityLabel.text = fullInfo?.getCityById(organization.cityId)
        cell.phoneLabel.text = "Тел.: " + organization.phone
        cell.addressLabel.text = "Адреса: " + organization.address
        cell.detailsAction = { [weak self] in
            UIApplication.shared.open(NSURL(string: organization.link)! as URL)
        }
        cell.bankInfoAction = { [weak self] in
            self?.detailsActionInItemAtIndex(index)
            print("Bank detailed information tapped")
        }
        cell.callPhoneAction = { [weak self] in
            UIApplication.shared.open(NSURL(string: "tell://"+organization.phone)! as URL, options: [:], completionHandler: nil)
            print("Call phone number at " + organization.phone)
        }
        return cell
    }
}
