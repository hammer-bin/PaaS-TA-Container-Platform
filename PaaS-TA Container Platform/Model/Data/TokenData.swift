//
//  TokenData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation

// MARK: - Token
struct TokenData: Codable {
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "AccessToken"
        case refreshToken = "RefreshToken"
    }
}
