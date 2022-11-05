//
//  RSData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import Foundation

struct RSData: Codable {
    let name, namespace, pods: String
    let image: [String]
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name, namespace, pods, image
        case createdTime = "created_time"
    }
}
