//
//  signupViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 8/25/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class signupViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var errLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Date Picker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        
        datePicker.addTarget(self, action: #selector(dateChosen(_:)), for: .touchUpInside)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Actions
    @IBAction func dateChosen(_ sender: Any) {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    
    @IBAction func submitForm(_ sender: UIButton) {
        if(checkFields(first: firstNameTextField.text!, last: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, confirm: confirmPassTextField.text!) == true){
            
            if(passwordMatch(pwd: passwordTextField.text!, confirm: confirmPassTextField.text!) == true){
                

                sendHTTPRequest(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, eml: emailTextField.text!, pwd: confirmPassTextField.text!)
                
                performSegue(withIdentifier: "toHomeSegue", sender: (Any).self)
                
            }
        }
    }
    
    
    //Functions
    func checkFields(first: String, last: String, email: String, password: String, confirm: String) -> Bool{
        
        if(first.isEmpty || last.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty){
            errLabel.text = "Please fill all required fields"
            return false
        }else{
            return true
        }
    }
    
    func passwordMatch(pwd: String, confirm: String) -> Bool{
        if(pwd != confirm){
            print("Passwords do not match")
            errLabel.text = "Passwords do not match"
            return false
        }else{
            return true
        }
    }
    
    
    
    //HTTP Request
    func sendHTTPRequest(firstName: String, lastName: String, eml: String, pwd: String){
        
        let nme = firstName + lastName
        let parameters = [
            //"name": nme,
            //"birthday": "123456",
            "email": eml,
            "password": pwd,
            //"school": school
        ]
        
        Alamofire.request("https://4f6a17aa.ngrok.io/info", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
                print(response)
        }
        
    }
}
