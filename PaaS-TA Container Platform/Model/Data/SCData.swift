//
//  SCData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/02.
//

import Foundation

struct SCData: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var provider: String?
    var parameter: [String]?
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name, provider, parameter
        case createdTime = "created_time"
    }
}
