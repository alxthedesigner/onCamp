//
//  schoolSelectionViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 8/22/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit

class schoolSelectionViewController: UIViewController {

    @IBOutlet var schoolButtons: [UIButton]!
    var backgroundColor: UIColor!
    var textColor: UIColor!
    
    
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
    
    
    
    //MARK: SCHOOL DROPDOWN MENU
    @IBAction func showSchoolsMenu(_ sender: UIButton) {
        schoolButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations:{
                
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    //MARK: School Colors
    @IBAction func schoolTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let school = Schools(rawValue: title) else {
            return
        }
        switch school{
        case .kysu:
            backgroundColor = UIColor(red: 249/255.0, green: 226/255.0, blue: 55/255.0, alpha: 1);
            textColor = UIColor(red: 2/255.0, green: 106/255.0, blue: 55/255.0, alpha: 1);
            print("KYSU selected")
            performSegue(withIdentifier: "toLoginScreen", sender: UIButton?.self)
            
        case .lou:
            backgroundColor = UIColor(red: 181/255.0, green: 49/255.0, blue: 53/255.0, alpha: 1);
            textColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1);
            print("Louisville selected")
            performSegue(withIdentifier: "toLoginScreen", sender: UIButton?.self)
            
        case .uk:
            backgroundColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1);
            textColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1);
            
            print("UK selected")
            performSegue(withIdentifier: "toLoginScreen", sender: UIButton?.self)
            
        default:
            print("No school selected")
        }
    }
    
    
    @IBAction func unwindToSchoolSelect(_ sender: UIStoryboardSegue){}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! loginScreenViewController
        
        //BACKGROUND COLOR
        destinationVC.view.backgroundColor = backgroundColor
        
        //TEXT COLOR
        destinationVC.changeSchoolsButton.setTitleColor(textColor, for: .normal)
        destinationVC.forgotPasswordButton.setTitleColor(textColor, for: .normal)
       // destinationVC.loginButton.setTitleColor(textColor, for: .normal)
    }
    

}
