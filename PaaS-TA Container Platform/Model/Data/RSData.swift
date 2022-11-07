//
//  RSData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import Foundation

struct RSData: Codable, Identifiable {
    var id: UUID = UUID()
    var name, namespace: String
    var pods: String?
    var image: [String]?
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name, namespace, pods, image
        case createdTime = "created_time"
    }
}
