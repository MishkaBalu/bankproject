//
//  BankInfoTableViewCell.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 12/15/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import UIKit
import SDWebImage

class BankInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var backgroundCustomView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var linkButton: UIButton!
    
    var detailsAction: (() -> Void)?
    var bankInfoAction: (() -> Void)?
    var callPhoneAction: (() -> Void)?
    
    @IBAction func linkPressed(_ sender: Any) {
        detailsAction?()
    }
    
    @IBAction func morePressed(_ sender: Any) {
        bankInfoAction?()
    }
    
    @IBAction func callPressed(_ sender: Any) {
        callPhoneAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bankImageView.sd_cancelCurrentImageLoad()
    }
    
    private func setupLayout() {
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 5
        bottomView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        backgroundCustomView.layer.cornerRadius = 5
        
        backgroundCustomView.layer.shadowColor = UIColor.gray.cgColor
        backgroundCustomView.layer.shadowOpacity = 0.75
        backgroundCustomView.layer.shadowOffset = CGSize.zero
        backgroundCustomView.layer.shadowRadius = 5
    }
}
