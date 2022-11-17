//
//  ResourceQuotaInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import Foundation

struct ResourceQuotaInfo: Codable {
    var detailRQ: DetailRQ

    enum CodingKeys: String, CodingKey {
        case detailRQ = "DetailRQ"
    }
}

// MARK: - DetailRQ
struct DetailRQ: Codable {
    var name, namespace: String
    var scopes: String?
    var status: [Status]?
    var createdTime: String?
}

// MARK: - Status
struct Status: Codable, Hashable {
    var resourceName, hard, used: String?

    enum CodingKeys: String, CodingKey {
        case resourceName = "resource_name"
        case hard, used
    }
}
