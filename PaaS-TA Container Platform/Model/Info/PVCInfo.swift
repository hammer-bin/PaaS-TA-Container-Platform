//
//  PVCInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation

struct PVCInfo: Codable {
    var detailPVC: DetailPVC
    var resourcePVC: ResourcePVC
}

// MARK: - DetailPVC
struct DetailPVC: Codable {
    var name, uid, namespace: String
    var labels: [String]?
    var annotations: [String]?
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace
        case labels = "Labels"
        case annotations = "Annotations"
        case createdTime
    }
}

// MARK: - ResourcePVC
struct ResourcePVC: Codable {
    var status, storageClass: String
    var capacity: Capacity
    var accessMode: [String]?

    enum CodingKeys: String, CodingKey {
        case status, storageClass
        case capacity = "Capacity"
        case accessMode = "access_mode"
    }
}

// MARK: - Capacity
struct Capacity: Codable {
    var storage: String
}

