//
//  SCInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/02.
//

import Foundation

struct SCInfo: Codable {
    let detailSc: DetailSc
    let resourceSc: ResourceSc

    enum CodingKeys: String, CodingKey {
        case detailSc = "detail_sc"
        case resourceSc = "resource_sc"
    }
}

// MARK: - DetailSc
struct DetailSc: Codable {
    let name, uid: String
    let labels, annotations: [String]
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case labels, annotations, createdTime
    }
}

// MARK: - ResourceSc
struct ResourceSc: Codable {
    let provider, archiveOnDelete: String

    enum CodingKeys: String, CodingKey {
        case provider
        case archiveOnDelete = "archive_on_delete"
    }
}
