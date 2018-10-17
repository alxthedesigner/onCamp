//
//  menuTableViewController.swift
//  
//
//  Created by Alex Stanford on 10/10/18.
//

import UIKit
import Alamofire
import SwiftyJSON

class Meals{
    
    var name: String
    var photo: UIImage?
    var desc: String
    var price: Double
    var restaurant: String
    
    init?(name: String, photo: UIImage?, desc: String, price: Double, restaurant: String) {

        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.desc = desc
        self.price = price
        self.restaurant = restaurant
    }
}
var destPlace = ""
class menuTableViewController: UITableViewController {

    @IBOutlet var menuTable: UITableView!
    
    var getObjects = [[String:AnyObject]]()
    var items = [Meals]()
    let identifier = "menuCellIdentifier"
    let url = "https://1310fd61.ngrok.io/menu"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //loadMeals()
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

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
    performSegue(withIdentifier: "showMenuItemSegue", sender: (Any).self)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? menuItemTableViewCell else {
            fatalError("Cell not dequeued")
        }
        
        var dict = getObjects[indexPath.row]
        //RESTAURANTS
        
        if(dict["restaurant"] as! String == destPlace){
        cell.itemLabel?.text = dict["item"] as? String
        cell.descLabel?.text = dict["description"] as? String
        cell.priceLabel?.text = String(dict["price"] as! Double)
           print(destPlace)
          
        }
        return cell
        
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? menuItemTableViewCell else {
            fatalError("Cell not dequeued")
            
        }
     
        let item = items[indexPath.row]
        cell.itemLabel.text = item.name
        cell.itemImage.image = item.photo
        cell.descLabel.text = item.desc
        cell.priceLabel.tag = Int(item.price as Double)
        
        return cell
    }
    */
    
    //MARK: Functions
    private func loadMeals(){
        
        let chiKobImage = UIImage(named: "ChickenKabobs")
        let steKobImage = UIImage(named: "SteakKabobs")
        let sausKobImage = UIImage(named: "SausageKabobs")
        let shriKobImage = UIImage(named: "ShrimpKabobs")
        let vegKobImage = UIImage(named: "VeggieKabobs")
        
        
        guard let chickenKobob = Meals(name: "Chicken Kobob", photo: chiKobImage, desc: "", price: 5.00, restaurant: "Kobobinit") else{
            fatalError("Unable to instantiate meal")
        }
        guard let steakKobob = Meals(name: "Steak Kobob", photo: steKobImage, desc: "", price: 7.00, restaurant: "Kobobinit") else{
            fatalError("Unable to instantiate meal")
        }
        guard let sausageKobob = Meals(name: "Sausage Kobob", photo: sausKobImage, desc: "", price: 5.00, restaurant: "Kobobinit") else{
            fatalError("Unable to instantiate meal")
        }
        guard let shrimpKobob = Meals(name: "Shrimp Kobob", photo: shriKobImage, desc: "", price: 7.00, restaurant: "Kobobinit") else{
            fatalError("Unable to instantiate meal")
        }
        guard let veggieKobob = Meals(name: "Veggie Kobob", photo: vegKobImage, desc: "", price: 5.00, restaurant: "Kobobinit") else{
            fatalError("Unable to instantiate meal")
        }
        
        items += [chickenKobob, steakKobob, sausageKobob, shrimpKobob, veggieKobob]
    }
    
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenuItemSegue"{
            let location1 = segue.destination as! ViewController
            let location2 = menuItemTableViewCell()
         
        }
        
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
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
