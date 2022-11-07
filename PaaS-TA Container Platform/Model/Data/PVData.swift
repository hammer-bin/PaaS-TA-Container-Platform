//
//  PVData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/17.
//

import Foundation

struct PVData: Codable, Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var capacity: String?
    var accessMode: [String]?
    var status: String?
    var claim: String?
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name
        case capacity
        case accessMode = "access_mode"
        case status
        case claim
        case createdTime = "created_time"
    }
}
