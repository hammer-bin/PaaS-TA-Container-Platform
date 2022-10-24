//
//  ServiceData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/09.
//

import Foundation

struct ServiceData: Codable, Identifiable {
    var id: UUID = UUID()
    var name, namespace, type, clusterIP: String
    var createdTime: String
    var offset: CGFloat = 0

    enum CodingKeys: String, CodingKey {
        case name, namespace, type
        case clusterIP = "cluster_ip"
        case createdTime = "created_time"
    }
}

struct ServiceInnerData {
    var id: UUID = UUID()
    var name, namespace, type, clusterIP: String
    var createdTime: String
    var offset: CGFloat = 0
}
