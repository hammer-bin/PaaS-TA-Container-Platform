//
//  SecretData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import Foundation

struct SecretData: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var namespace: String
    var type: String?
    var createdTime: String?
    
    enum CodingKeys: String, CodingKey {
        case name, namespace, type
        case createdTime = "created_time"
    }
}
