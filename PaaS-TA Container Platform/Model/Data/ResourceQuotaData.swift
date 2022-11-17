//
//  ResourceQuotaData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import Foundation

struct ResourceQuotaData: Codable, Identifiable {
    var id: UUID = UUID()
    var name, namespace: String
    var status: String?
    var createdTime: String?

    enum CodingKeys: String, CodingKey {
        case name, namespace
        case status = "Status"
        case createdTime = "created_time"
    }
}
