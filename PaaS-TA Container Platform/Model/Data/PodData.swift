//
//  PodData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/03.
//

import Foundation

struct PodData: Codable, Identifiable {
    var id: UUID = UUID()
    let name, namespace, node, status: String
    let restarts: Int
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name, namespace, node, status, restarts
        case createdTime = "created_time"
    }
}
