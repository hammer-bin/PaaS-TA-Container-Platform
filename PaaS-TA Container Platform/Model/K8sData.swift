//
//  K8sData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/18.
//

import Foundation
// MARK: - Token
struct K8sData: Codable {
    let k8sToken, apiUrl: String

    enum CodingKeys: String, CodingKey {
        case k8sToken = "k8s_token"
        case apiUrl = "api_url"
    }
}
