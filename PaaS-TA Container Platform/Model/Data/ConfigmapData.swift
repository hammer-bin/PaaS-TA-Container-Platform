//
//  ConfigmapInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import Foundation

struct ConfigmapData: Codable, Identifiable {
    var id: UUID = UUID()
    var name, namespace: String
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name, namespace
        case createdTime = "created_time"
    }
}
