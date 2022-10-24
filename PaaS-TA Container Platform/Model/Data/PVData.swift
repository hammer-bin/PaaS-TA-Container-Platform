//
//  PVData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/17.
//

import Foundation

struct PVData: Codable, Identifiable {
    
    var id: UUID = UUID()
    let name, capacity: String
    let accessMode: [String]
    let status, claim: String
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name, capacity
        case accessMode = "access_mode"
        case status, claim
        case createdTime = "created_time"
    }
}
