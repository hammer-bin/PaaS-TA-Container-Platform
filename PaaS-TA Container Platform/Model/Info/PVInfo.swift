//
//  PVInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/17.
//

import Foundation

// MARK: - PVInfo
struct PVInfo: Codable {
    var detailPV: DetailPV
    var resourcePV: ResourcePV
    var sourcePV: SourcePV
    var capacityPV: CapacityPV

    enum CodingKeys: String, CodingKey {
        case detailPV = "detail_pv"
        case resourcePV = "resource_pv"
        case sourcePV = "source_pv"
        case capacityPV = "capacity_pv"
    }
}

// MARK: - CapacityPV
struct CapacityPV: Codable {
    let resourceName, capacity: String

    enum CodingKeys: String, CodingKey {
        case resourceName = "resource_name"
        case capacity
    }
}

// MARK: - DetailPV
struct DetailPV: Codable {
    var name, uid: String?
    var labels: [String]?
    var annotations: [String]?
    var createdTime: String?
 
    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case labels, annotations, createdTime
    }
}

// MARK: - ResourcePV
struct ResourcePV: Codable {
    var status, claim, returnPolicy, storageClass: String
    var accessMode: [String]

    enum CodingKeys: String, CodingKey {
        case status, claim
        case returnPolicy = "return_policy"
        case storageClass = "storage_class"
        case accessMode = "access_mode"
    }
}

// MARK: - SourcePV
struct SourcePV: Codable {
    var type, server, path: String
}
