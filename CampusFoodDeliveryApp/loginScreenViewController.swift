//
//  loginScreenViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 8/3/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit


class loginScreenViewController: UIViewController {
    
    @IBOutlet var schoolButtons: [UIButton]!
    
    
    
    

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var changeSchoolsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum Schools: String{
        case kysu = "Kentucky State University"
        case lou = "University of Louisville"
        case uk = "University of Kentucky"
        
    }
    
    @IBAction func showSchoolsMenu(_ sender: UIButton) {
        schoolButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations:{
                
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    @IBAction func schoolTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let school = Schools(rawValue: title) else {
            return
        }
        
        switch school{
        case .kysu:
            changeSchoolsButton.setTitle("Kentucky State University", for: .normal)
            print("KYSU selected")
            
        case .lou:
            changeSchoolsButton.setTitle("University of Louisville", for: .normal)
            print("Louisville selected")
            
        case .uk:
            changeSchoolsButton.setTitle("University of Kentucky", for: .normal)
            print("UK selected")
            
        default:
            print("No school selected")
        }
    }
   
    
}
