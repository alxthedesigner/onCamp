//
//  menuItemTableViewCell.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 10/10/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit

class menuItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
