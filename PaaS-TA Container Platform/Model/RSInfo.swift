//
//  RSInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import Foundation

// MARK: - Post
struct RSInfo: Codable {
    let detailRS: DetailRS
    let resourceRS: ResourceRS
}

// MARK: - DetailRS
struct DetailRS: Codable {
    let name, uid, namespace: String
    let labels: [String]
    let annotations: Annotations
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace
        case labels = "Labels"
        case annotations = "Annotations"
        case createdTime
    }
}

// MARK: - Annotations
struct Annotations: Codable {
    let deploymentKubernetesIoDesiredReplicas, deploymentKubernetesIoMaxReplicas, deploymentKubernetesIoRevision: String

    enum CodingKeys: String, CodingKey {
        case deploymentKubernetesIoDesiredReplicas = "deployment.kubernetes.io/desired-replicas"
        case deploymentKubernetesIoMaxReplicas = "deployment.kubernetes.io/max-replicas"
        case deploymentKubernetesIoRevision = "deployment.kubernetes.io/revision"
    }
}

// MARK: - Labels
struct Labels: Codable {
    let app, podTemplateHash: String

    enum CodingKeys: String, CodingKey {
        case app
        case podTemplateHash = "pod-template-hash"
    }
}

// MARK: - ResourceRS
struct ResourceRS: Codable {
    let selector, image: [String]

    enum CodingKeys: String, CodingKey {
        case selector = "Selector"
        case image
    }
}
