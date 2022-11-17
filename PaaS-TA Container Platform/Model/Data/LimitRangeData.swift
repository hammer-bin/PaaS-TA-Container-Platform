//
//  LimitRangeData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import Foundation

struct LimitRangeData: Codable, Identifiable {
    var id: UUID = UUID()
    var name, namespace: String
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name, namespace
        case createdTime = "created_time"
    }
}
