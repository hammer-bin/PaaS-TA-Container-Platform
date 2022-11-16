//
//  ConfigmapResponse.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import Foundation

struct ConfigmapResponse: Codable {
    let data: [ConfigmapData]?
}
