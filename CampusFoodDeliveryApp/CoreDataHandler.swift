//
//  CoreDataHandler.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 10/27/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {

    class func objectContext() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    
    
    //Save Product
    class func saveProduct(descript: String, item: String, price: Double){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let user = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
        
        user.setValue(descript, forKey: "descript")
        //user.setValue(id, forKey: "id")
        user.setValue(item, forKey: "item")
        user.setValue(price, forKey: "price")
        
        do{
            try context.save()
            print("Product saved")
        }
        catch{
            print("PRODUCT NOT SAVED")
        }
    }
    
    
    //Fetch Product
    class func fetchProduct() -> [ProductMO]?{
        
        let context = objectContext()
        var product:[ProductMO]? = nil
        /*var products = [ProductMO]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        request.returnsObjectsAsFaults = false
        */
        
        
        
   
        do  {
            product = try context.fetch(ProductMO.fetchRequest())
            /*var product = try context.fetch(request)
            
            for prod in product as! [NSManagedObject] {
                print(prod)
                products.append(prod as! ProductMO)
            }*/
        }
        catch
        {
            print("Could not fetch product")
            return product
            //return products
        }
        print("Product fetched sucessfully!")
        return product
        //return products
        
    }
    
    
    
    //Delete Single Product
    class func deleteProduct(){
        let context = objectContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        request.returnsObjectsAsFaults = false
        
        do{
            let deleteThis = try context.fetch(request)
            //STOP LOOPING
            for obj in deleteThis as! [NSManagedObject] {
            context.delete(obj)
            }
        }catch{
            fatalError()
        }
        
        do{
            try context.save()
        }catch{
            print(fatalError())
        }
    }
    
    
    //Clear All Products
   /* class func clearAllProducts(ent: String){
        let context = objectContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ent)
        request.returnsObjectsAsFaults = false
        
        do{
            let res = try context.fetch(ProductMO.fetchRequest())
            
            for obj in res {
                guard let prods = obj as? NSManagedObject else {continue}
                objectContext().delete(prods)
                print("All products cleared")
            }
            
        }catch let error {
            print("Error: \(error)")
        }
    }*/
    
}
