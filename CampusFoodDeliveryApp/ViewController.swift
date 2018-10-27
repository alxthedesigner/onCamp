//
//  ViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 8/2/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var pricey: UILabel!
    
    
    var retrieveItem : String = ""
    var retrieveDesc : String = ""
    var retrievePrice : Double = 0
    //var itemId = UUID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assigning retrived items to current labels
        print(retrieveItem)
        item.text? = retrieveItem
        descript.text? = retrieveDesc
        pricey.text? = String(retrievePrice)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func addToCart(_ sender: UIButton) {
        CoreDataHandler.saveProduct(descript: retrieveDesc, item: retrieveItem, price: retrievePrice)
        
    }
    
}



