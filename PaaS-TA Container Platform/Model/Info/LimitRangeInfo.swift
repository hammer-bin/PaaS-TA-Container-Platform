//
//  LimitRangeInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import Foundation

struct LimitRangeInfo: Codable {
    var detailRQ: DetailLR

    enum CodingKeys: String, CodingKey {
        case detailRQ = "DetailRQ"
    }
}

// MARK: - DetailRQ
struct DetailLR: Codable {
    var name, namespace: String
    var status: [StatusLR]?
    var createdTime: String?
}

// MARK: - Status
struct StatusLR: Codable {
    var type, resource, min, max: String?
    var defaultRequest, defaultLimit: String?

    enum CodingKeys: String, CodingKey {
        case type, resource, min, max
        case defaultRequest = "default_request"
        case defaultLimit = "default_limit"
    }
}
