//
//  cartTableViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 10/20/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit

class cartTableViewController: UITableViewController{
    
    //viewController.delegate = self
    
    @IBOutlet var cartTable: UITableView!
    var cartIdentifier = "cartCellIdentifier"
    
    var productList:[ProductMO]? = nil
    
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
        productList = CoreDataHandler.fetchProduct()
        return productList!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cartIdentifier, for: indexPath) as? cartTableViewCell
        
        productList = CoreDataHandler.fetchProduct()
        let prod = productList![indexPath.row]
        
        //CoreDataHandler.clearAllProducts(ent: "Product")
        
        cell!.cartItemLabel.text = prod.item
        cell!.cartPriceLabel.text = String(prod.price)
        return cell!
    }
    
    
    
    /*func getProducts(){
   //productList = CoreDataHandler.fetchProduct()
        for i in productList!{
            i.descript = passDesc
            i.item = passItem
            i.price = passPrice
            //counter+=1
        }
        //couter = (productList?.count)!
    }*/
    
    

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
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
