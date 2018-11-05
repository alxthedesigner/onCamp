//
//  loginScreenViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 8/3/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class loginScreenViewController: UIViewController {
    
    
    let url = "https://905f9a4b.ngrok.io/users"
    //var getUrlVC = loginScreenViewController()
    var userObjects = [[String:AnyObject]]()
    @IBOutlet var schoolButtons: [UIButton]!
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    
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
    
    //let url = getUrlVC.url
    @IBAction func logInButton(_ sender: UIButton) {
        let password = loginPasswordTextField.text!
        let email = loginEmailTextField.text!
        getUser(eml: email, pwd: password, url: url)
    }
    
    
    
    //GET request filtered
    func getUser(eml: String, pwd: String, url: String){
        Alamofire.request(url).authenticate(user: eml, password: pwd).responseJSON{ response in
            switch response.result {
            case .success:
                let jsonRes = JSON(response.result.value!)
                
                if let data = jsonRes.arrayObject {
                    self.userObjects = data as! [[String:AnyObject]]
                }
                
                for i in self.userObjects{
                    let value = (i["email"]! as! String)
                    if(value == eml){
                        print("Successful GET request")
                        self.performSegue(withIdentifier: "loginToHomeSegue", sender: Any?.self)
                    }
                }
                
            case .failure(let error):
                print("Login Failed")
                print(0,"Error: \(error)")
            }
        }
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
