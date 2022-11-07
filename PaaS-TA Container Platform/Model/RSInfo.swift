//
//  RSInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import Foundation

// MARK: - Post
struct RSInfo: Codable {
    let detailRS: DetailRS
    let resourceRS: ResourceRS
}

// MARK: - DetailRS
struct DetailRS: Codable {
    let name, uid, namespace: String
    let labels: [String]
    let annotations: [String]
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace
        case labels = "Labels"
        case annotations = "Annotations"
        case createdTime
    }
}

// MARK: - ResourceRS
struct ResourceRS: Codable {
    let selector, image: [String]

    enum CodingKeys: String, CodingKey {
        case selector = "Selector"
        case image
    }
}
