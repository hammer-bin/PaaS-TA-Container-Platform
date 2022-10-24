//
//  IngressInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/19.
//

import Foundation

// MARK: - IngressInfo
struct IngressInfo: Codable {
    let detailIngress: DetailIngress
    let resourceIngress: [ResourceIngress]

    enum CodingKeys: String, CodingKey {
        case detailIngress = "detail_ingress"
        case resourceIngress = "resource_ingress"
    }
}

// MARK: - DetailIngress
struct DetailIngress: Codable {
    let name, uid, namespace: String
    let createdTime: Date

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace, createdTime
    }
}

// MARK: - ResourceIngress
struct ResourceIngress: Codable {
    let host, pathType, path, targetSVC: String
    let targetPort: Int

    enum CodingKeys: String, CodingKey {
        case host, pathType, path, targetSVC
        case targetPort = "TargetPort"
    }
}
