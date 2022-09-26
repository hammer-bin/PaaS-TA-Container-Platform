//
//  UserData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation

struct UserData : Codable, Identifiable {
    
    var uuid: UUID = UUID()
    var id : Int
    var name: String
    var email : String
    var avatar : String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case avatar
    }
}
