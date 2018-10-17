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
    
    let url = "https://6fc60b57.ngrok.io/users"
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
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
    
    enum Schools: String{
        case kysu = "Kentucky State University"
        case lou = "University of Louisville"
        case uk = "University of Kentucky"
        
    }
    
    @IBAction func schoolBtn(_ sender: Any) {
        
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
            print("KYSU selected")

        case .lou:
            print("Louisville selected")
            
        case .uk:
            print("UK selected")

        default:
            print("No school selected")
        }
        
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
                

                postUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, eml: emailTextField.text!, pwd: confirmPassTextField.text!, skool: "" )
                
                performSegue(withIdentifier: "toHomeSegue", sender: (Any).self)
                
            }
        }
    }
    
    
    //MARK: Functions
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
    func postUser(firstName: String, lastName: String, eml: String, pwd: String, skool: String){
        
        //let url = "https://6fc60b57.ngrok.io/users"
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Accept": "application/json"
        ]
        let nme = firstName + lastName
        let parameters = [
            "name": nme,
            "email": eml,
            "password": pwd,
            "school": skool
        ]
        
        //POST request
        Alamofire.request(url, method: .post, parameters:
            parameters, encoding: JSONEncoding.default, headers: header)
            .responseString { response in
                switch response.result {
                case .success:
                    self.getUser(eml: eml, pwd: pwd, url: self.url)
                    print(response)
                case .failure(let error):
                    print(0,"Error: \(error)")
                }
            }
    }
    
    
    
    func getUser(eml: String, pwd: String, url: String){

        let params = [
            "email": eml,
            "password": pwd
        ]
        //GET request
        Alamofire.request(url, parameters: params).responseJSON{ response in
            switch response.result {
                case .success:
                print("Successful GET request")
                case .failure(let error):
                    print(0,"Error: \(error)")
            }
            
            //print(response)
        }
    }
    
    
}
