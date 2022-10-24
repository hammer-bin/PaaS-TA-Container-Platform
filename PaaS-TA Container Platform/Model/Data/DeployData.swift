//
//  DeployData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/02.
//

import Foundation

struct DeployData: Codable, Identifiable {
    var id: UUID = UUID()
    let name, namespace: String
    let replicas, availableReplicas: Int
    let image: [String]
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name, namespace, replicas, availableReplicas, image
        case createdTime = "created_time"
    }
}
