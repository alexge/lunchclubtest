//
//  Contact.swift
//  LunchclubTest
//
//  Created by Alexander Ge on 06/08/2021.
//

import Foundation

struct LCContact: Codable {
    let id: String
    var number: String?
    var first: String?
    var last: String?
    var avatar: String?
    var notes: String?
}
