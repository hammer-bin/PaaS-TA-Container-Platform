//
//  PVInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/17.
//

import Foundation

// MARK: - PVInfo
struct PVInfo: Codable {
    let detailPV: DetailPV
    let resourcePV: ResourcePV
    let sourcePV: SourcePV
    let capacityPV: CapacityPV

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
    let name, uid: String
    let labels: JSONNull?
    let annotations: [String]
    let createdTime: Date

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case labels, annotations, createdTime
    }
}

// MARK: - ResourcePV
struct ResourcePV: Codable {
    let status, claim, returnPolicy, storageClass: String
    let accessMode: [String]

    enum CodingKeys: String, CodingKey {
        case status, claim
        case returnPolicy = "return_policy"
        case storageClass = "storage_class"
        case accessMode = "access_mode"
    }
}

// MARK: - SourcePV
struct SourcePV: Codable {
    let type, server, path: String
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
