//
//  ContactRequestPerformer.swift
//  LunchclubTest
//
//  Created by Alexander Ge on 06/08/2021.
//

import Foundation

struct ResponseType: Codable {
    let contacts: [LCContact]
}

class ContactRequestPerformer {
    
    let consumer = Consumer()
    let baseURL = URL(string: "https://address-book-lunchclub.herokuapp.com/")!
    
    func requestAllContacts(completion: @escaping ([LCContact]?) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("contacts/"))
        request.setValue("alexinter", forHTTPHeaderField: "Authorization")
        
        consumer.response(of: request, completionHandler: { (response, error) in
            completion(response?.contacts)
        } as ResponseTypedCompletion<ResponseType>)
    }
    
}
