//
//  menuTableViewController.swift
//  
//
//  Created by Alex Stanford on 10/10/18.
//

import UIKit
import Alamofire
import SwiftyJSON


var destPlace = ""
class menuTableViewController: UITableViewController{

    @IBOutlet var menuTable: UITableView!
    
    var getObjects = [[String:AnyObject]]()
    let identifier = "menuCellIdentifier"
    let url = "https://48309c31.ngrok.io/menu"
    
    @IBAction func viewCartPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCartSegue", sender: Any?.self)
    }
    var passItem : String!
    var passDesc : String!
    var passPrice : Double!
    var passId : UUID!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
   
        getMenuItems()
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
        //return items.count
        return getObjects.count
        
        }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("SELECTION WORKS")
        
        let indexPath = menuTable.indexPathForSelectedRow!
        let current = menuTable.cellForRow(at: indexPath)! as! menuItemTableViewCell

        passItem = current.itemLabel.text!
        passDesc = current.descLabel.text!
        passPrice = NSString(string: current.priceLabel.text!).doubleValue
        
        print(passItem + passDesc)
        print(passPrice)
        performSegue(withIdentifier: "showItemDetails", sender: (Any).self)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? menuItemTableViewCell
        
        var dict = getObjects[indexPath.row]
        //RESTAURANTS
        //if(dict["restaurant"] as! String == destPlace){
            cell?.itemLabel.text = dict["item"] as? String
            cell?.descLabel.text = dict["description"] as? String
            cell?.priceLabel.text = String(dict["price"] as! Double)
            print(destPlace)
                
                //passId = dict["id"] as! UUID
            //}
        
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showItemDetails"){
            let vc = segue.destination as! ViewController
        
            vc.retrieveItem = passItem
            vc.retrieveDesc = passDesc
            vc.retrievePrice = passPrice
            //vc.itemId = passId
        }
    }
    
    //MARK: Functions
    
    func getMenuItems(){
        Alamofire.request(url).responseJSON{ response -> Void in
            if((response.result.value) != nil) {
                let jsonVar = JSON(response.result.value!)
                print(jsonVar)
                
                if let data = jsonVar.arrayObject {
                    self.getObjects = data as! [[String:AnyObject]]
                }
                
                if self.getObjects.count > 0 {
                        self.menuTable.reloadData()
                }
            }
        }
    }
    
    @IBAction func dismissMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
    }
 */

}
