//
//  DeployInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/09.
//

import Foundation

// MARK: - DeployInfo
struct DeployInfo: Codable {
    let detail: DeployDetail
    let resourceInfo: ResourceInfo
    let updateStrategy: UpdateStrategy
    let podStatus: PodStatus

    enum CodingKeys: String, CodingKey {
        case detail = "Detail"
        case resourceInfo = "ResourceInfo"
        case updateStrategy = "UpdateStrategy"
        case podStatus = "PodStatus"
    }
}

// MARK: - DeployDetail
struct DeployDetail: Codable {
    let name, uid, namespace: String?
    let createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace
        case createdTime
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        uid = (try? values.decode(String.self, forKey: .uid)) ?? ""
        namespace = (try? values.decode(String.self, forKey: .namespace)) ?? ""
        createdTime = (try? values.decode(String.self, forKey: .createdTime)) ?? nil
        
    }
}

// MARK: - DeployLabels
struct DeployLabels: Codable {
    let app: String
}

// MARK: - PodStatus
struct PodStatus: Codable {
    let updated, total, available: Int
}

// MARK: - ResourceInfo
struct ResourceInfo: Codable {
    let strategy: String
    let minReadySeconds, revisionHistoryLimit: Int
    let selector: Selector
}

// MARK: - Selector
struct Selector: Codable {
    let matchLabels: MatchLabels
}

struct MatchLabels: Codable {
    var app: String
}

// MARK: - UpdateStrategy
struct UpdateStrategy: Codable {
    let maxSurge, maxUnavailable: String
}
