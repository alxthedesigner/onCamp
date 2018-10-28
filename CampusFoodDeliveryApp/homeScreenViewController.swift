//
//  homeScreenViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 8/3/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit
import Alamofire

class homeScreenViewController: UIViewController {

    @IBOutlet var restaurantCollection: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum Places: String{
        case kb = "Kobobinit"
        case subway = "Subway"
        case popeye = "Popeyes"
        
    }
    
    //var vc = destPlace

    @IBAction func restaurantChoice(sender: UIButton){
        guard let title = sender.currentTitle, let places = Places(rawValue: title) else{ return }
    switch places{
    case .kb:
        destPlace = "Kobobinit"
        
        performSegue(withIdentifier: "showMenuSegue", sender: UIButton.self)

    case .subway:
        destPlace = "Subway"
        performSegue(withIdentifier: "showMenuSegue", sender: UIButton.self)

    case .popeye:
        destPlace = "Popeyes"
        performSegue(withIdentifier: "showMenuSegue", sender: UIButton.self)
        }
    
    }
    
}







    
