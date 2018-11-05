//
//  cartTableViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 10/20/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit

class cartTableViewController: UITableViewController{
    
    @IBOutlet var cartTable: UITableView!
    var cartIdentifier = "cartCellIdentifier"
    
    //var productList:[ProductMO]? = nil
    var productList = CoreDataHandler.fetchProduct()
    
    var passItem : String!
    var passDesc : String!
    var passPrice : Double!
    //var passId : String!
    
    var counter : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTable.rowHeight = 90.0
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //productList = CoreDataHandler.fetchProduct()
        return productList!.count
    }

    var prod = ProductMO()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cartIdentifier, for: indexPath) as? cartTableViewCell
        
        prod = productList![indexPath.row]

        
        cell!.cartItemLabel.text = prod.item
        cell!.cartPriceLabel.text = String(prod.price)
        
        return cell!
    }
 
    
    @IBAction func submitOrderButton(_ sender: UIBarButtonItem) {
        
        let product = prod.item
        let price = prod.price
        let checkoutViewController = CheckoutViewController(product: (product)!,
                                                            price: Int(price),
                                                            settings: SettingsViewController().settings)
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == ""){
            let vc = segue.destination as! ViewController
            
            vc.retrieveItem = passItem
            vc.retrieveDesc = passDesc
            vc.retrievePrice = passPrice
            //vc.itemId = passId
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
     */
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
 
            //productList = CoreDataHandler.fetchProduct()
            CoreDataHandler.deleteProduct()
            productList!.remove(at: indexPath.row)
            cartTable.deleteRows(at: [indexPath], with: .automatic)
            
        }
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
