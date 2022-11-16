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
    var userID: String
    var k8sToken : String
    var apiUrl: String
    var isAdmin: Bool
    var nsName: String
    var k8sName: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case k8sToken = "k8s_token"
        case apiUrl = "api_url"
        case isAdmin = "is_admin"
        case nsName = "ns_name"
        case k8sName = "k8s_name"
    }
}
