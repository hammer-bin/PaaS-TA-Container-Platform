//
//  IngressData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/19.
//

import Foundation

// MARK: - Datum
struct IngressData: Codable, Identifiable {
    var id: UUID = UUID()
    var name, namespace: String
    var target: [String]
    var createdTime: String

    enum CodingKeys: String, CodingKey {
        case name, namespace, target
        case createdTime = "created_time"
    }
}
