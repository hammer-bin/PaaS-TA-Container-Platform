//
//  PVCInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation

struct PVCInfo: Codable {
    let detailPVC: DetailPVC
    let resourcePVC: ResourcePVC
}

// MARK: - DetailPVC
struct DetailPVC: Codable {
    let name, uid, namespace: String
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace
        case createdTime
    }
}

// MARK: - ResourcePVC
struct ResourcePVC: Codable {
    let status, storageClass: String
    let capacity: Capacity
    let accessMode: [String]

    enum CodingKeys: String, CodingKey {
        case status, storageClass
        case capacity = "Capacity"
        case accessMode = "access_mode"
    }
}

// MARK: - Capacity
struct Capacity: Codable {
    let storage: String
}

