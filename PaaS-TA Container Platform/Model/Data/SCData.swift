//
//  SCData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/02.
//

import Foundation

struct SCData: Codable, Identifiable {
    var id: UUID = UUID()
    let name, provider: String
    let parameter: [String]
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name, provider, parameter
        case createdTime = "created_time"
    }
}
