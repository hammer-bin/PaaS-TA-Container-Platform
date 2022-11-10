//
//  ServiceInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/03.
//

import Foundation

struct ServiceInfo: Codable {
    let detailService: DetailService
    let resourceService: ResourceService
}

// MARK: - DetailService
struct DetailService: Codable {
    let name, uid, namespace: String
    let labels, annotations: [String]?
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace, labels, annotations, createdTime
    }
}

// MARK: - ResourceService
struct ResourceService: Codable {
    let type, clusterIP, sessionAffinity: String
    let selector: [String]?

    enum CodingKeys: String, CodingKey {
        case type
        case clusterIP = "cluster_ip"
        case sessionAffinity = "session_affinity"
        case selector
    }
}
