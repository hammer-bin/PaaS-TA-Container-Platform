//
//  ConfigmapInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import Foundation

struct ConfigmapInfo: Codable {
    var kind, apiVersion: String
    var metadata: Metadata
    var data: [String]?

    enum CodingKeys: String, CodingKey {
        case kind, apiVersion, metadata
        case data = "Data"
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    var name, namespace, uid, resourceVersion: String
    var creationTimestamp: String
    var labels: [String]?
    var annotations: [String]?

    enum CodingKeys: String, CodingKey {
        case name, namespace, uid, resourceVersion, creationTimestamp
        case labels = "Labels"
        case annotations = "Annotations"
    }
}
