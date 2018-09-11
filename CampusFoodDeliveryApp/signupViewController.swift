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
    
    //Properties
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var errLabel: UILabel!
    
    
    @IBOutlet var schoolButtons: [UIButton]!
    
    
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
        if(fieldsFilled(school: schoolNameLabel.text! ,first: firstNameTextField.text!, last: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, confirm: confirmPassTextField.text!) == true){
            
            if(passwordMatch(pwd: passwordTextField.text!, confirm: confirmPassTextField.text!) == true){
                
                //Launch HTTP POST Request
                launchHttpRequest(first: firstNameTextField.text!, last: lastNameTextField.text!, birthday: dateLabel.text!, email: emailTextField.text!, password: passwordTextField.text!, school: schoolNameLabel.text!)
                
                performSegue(withIdentifier: "toHomeSegue", sender: (Any).self)
                
            }
        }
    }
    
    
    //Functions
    func fieldsFilled(school: String, first: String, last: String, email: String, password: String, confirm: String) -> Bool{
        
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
    
    
    func launchHttpRequest(first: String, last: String, birthday: String, email: String, password: String, school: String){
        
        let name = first + last
        //Request Parameters
        let parameters = [
            "name": name,
            "birthday": birthday,
            "email": email,
            "password": password,
            "school": school
        ]
        
        //HTTP Request
        Alamofire.request("http://myserver.com", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
        }
    }
    
    
    
    //MARK: Actions
    @IBAction func schoolSelectButton(_ sender: Any) {
        schoolButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations:{
                
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @IBAction func schoolTapped(_ sender: UIButton){
        guard let title = sender.currentTitle else{ return }
        schoolNameLabel.text = title
        
    }
    
}
