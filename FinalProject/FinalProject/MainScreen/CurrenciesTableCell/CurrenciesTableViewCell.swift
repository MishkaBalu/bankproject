//
//  CurrenciesTableViewCell.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 12/20/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var bidLabel: UILabel!
    @IBOutlet weak var askLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
