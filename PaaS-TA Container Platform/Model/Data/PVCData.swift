//
//  PVCData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation

struct PVCData: Codable, Identifiable {
    
    var id: UUID = UUID()
    var name, namespace, status, volume, capacity, createdTime: String

    enum CodingKeys: String, CodingKey {
        case name, namespace, status, volume, capacity
        case createdTime = "created_time"
    }
}
