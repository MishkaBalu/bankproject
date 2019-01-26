//
//  NetworkManager.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 12/15/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkManager {
    static let sharedInstance = NetworkManager()
}

protocol BankInfoProtocol {
    
}

extension NetworkManager: BankInfoProtocol {
    
    func getBankDetails(completion: @escaping (_ success: FullInfo?, _ error: String?) -> ()) {
        Alamofire.request("http://resources.finance.ua/ua/public/currency-cash.json", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if let JSON = response.result.value as? [String: Any]  {
                let allData = try? Mapper<FullInfo>().map(JSON: JSON)
                completion(allData, nil)
            }
        }
    }
}
