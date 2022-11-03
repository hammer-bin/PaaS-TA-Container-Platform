//
//  PVCResponse.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation
struct PVCResponse: Codable {
    let data: [PVCData]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
