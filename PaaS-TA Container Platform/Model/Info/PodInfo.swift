//
//  PodInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import Foundation

struct PodInfo: Codable {
    let detailPod: DetailPod
    let resourcePod: ResourcePod
    let containerPod: ContainerPod

    enum CodingKeys: String, CodingKey {
        case detailPod = "detail_pod"
        case resourcePod = "resource_pod"
        case containerPod = "container_pod"
    }
}

// MARK: - ContainerPod
struct ContainerPod: Codable {
    let name, image: [String]
}

// MARK: - DetailPod
struct DetailPod: Codable {
    let name, uid, namespace: String
    let labels, annotations: [String]
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case uid = "UID"
        case namespace, labels, annotations, createdTime
    }
}

// MARK: - ResourcePod
struct ResourcePod: Codable {
    let nodes, status, ip, qoSClass: String
    let restart: Int
    let controllers, volumes: [String]

    enum CodingKeys: String, CodingKey {
        case nodes, status, ip
        case qoSClass = "qo_s_class"
        case restart, controllers, volumes
    }
}
