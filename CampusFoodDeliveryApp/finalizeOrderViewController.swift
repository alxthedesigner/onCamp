//
//  finalizeOrderViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 12/3/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit

class finalizeOrderViewController: UIViewController {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var finalPriceLabel: UILabel!
    var finalPrice : Double = 0.00
    var locationName : String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalPriceLabel.text! = String(finalPrice)
        locationLabel.text! = locationName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
