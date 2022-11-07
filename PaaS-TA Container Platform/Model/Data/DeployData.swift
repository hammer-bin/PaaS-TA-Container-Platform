//
//  DeployData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/02.
//

import Foundation

struct DeployData: Codable, Identifiable {
    var id: UUID = UUID()
    var name, namespace: String
    var replicas: Int = 0
    var availableReplicas: Int = 0
    var image: [String]?
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name, namespace, replicas, availableReplicas, image
        case createdTime = "created_time"
    }
}
