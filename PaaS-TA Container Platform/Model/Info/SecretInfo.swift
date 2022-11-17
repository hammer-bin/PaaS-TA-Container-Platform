//
//  SecretInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import Foundation

struct SecretInfo: Codable {
    var kind, apiVersion: String
    var metadata: SecretMetadata
    var data: [String]?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case kind, apiVersion, metadata
        case data = "Data"
        case type
    }
}

// MARK: - Metadata
struct SecretMetadata: Codable {
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
