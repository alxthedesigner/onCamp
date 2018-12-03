//
//  chkOutViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 11/7/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit
import Stripe

class chkOutViewController: UIViewController, STPPaymentContextDelegate {
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFailToLoadWithError error: Error) {
        self.navigationController?.popViewController(animated: true)
        // Show the error to your user, etc.
    }
    
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        self.activityIndicator.animating = paymentContext.loading
        self.paymentButton.enabled = paymentContext.selectedPaymentMethod != nil
        self.paymentLabel.text = paymentContext.selectedPaymentMethod?.label
        self.paymentIcon.image = paymentContext.selectedPaymentMethod?.image
    }
    
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didCreatePaymentResult paymentResult: STPPaymentResult,
                        completion: @escaping STPErrorBlock) {
        
        
        MyAPIClient.createCharge(paymentResult.source.stripeID, completion: { (error: Error?) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        })
    }
    
    
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFinishWithStatus status: STPPaymentStatus,
                        error: Error?) {
        
        switch status {
        case .error:
            self.showError(error)
        case .success:
            self.showReceipt()
        case .userCancellation:
            return // Do nothing
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
