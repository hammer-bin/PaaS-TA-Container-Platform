//
//  File.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/22.
//

import Foundation

struct ApnsTokenData : Codable {
    var deviceToken : String
    
    private enum CodingKeys: String, CodingKey {
        case deviceToken = "device_token"
    }
}
