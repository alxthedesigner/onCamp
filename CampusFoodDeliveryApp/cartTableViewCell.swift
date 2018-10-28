//
//  cartTableViewCell.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 10/20/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit

class cartTableViewCell: UITableViewCell {
    @IBOutlet weak var cartItemLabel: UILabel!
    @IBOutlet weak var cartPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
