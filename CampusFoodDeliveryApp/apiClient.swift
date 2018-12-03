//
//  apiClient.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 11/7/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class apiClient: NSObject, STPEphemeralKeyProvider {

let baseURL = URL(string: "https://on-camp.herokuapp.com/")
let apiVer = "2018-10-31"
    
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = baseURL?.appendingPathComponent("ephemeral_keys")
        
        Alamofire.request(url!, method: .post, parameters: [
            "api_version": apiVer,
            "customer_id": "cus_Cks1ITK7xlTM1U"
            ]).validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let json):
                completion(json as? [String: AnyObject], nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    
    
    
}
