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
    var userName: String
    var k8sToken : String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userName  = "user_name"
        case k8sToken = "k8s_token"
    }
}
