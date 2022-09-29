//
//  PVCInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation

struct PVCInfo: Codable {
    let detailPVC: DetailPVC
    let resourcePVC: ResourcePVC
}

// MARK: - DetailPVC
struct DetailPVC: Codable {
    let name, uid, namespace: String
    let labels: Labels
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
    let pvKubernetesIoBindCompleted, pvKubernetesIoBoundByController, volumeBetaKubernetesIoStorageProvisioner, volumeKubernetesIoStorageProvisioner: String

    enum CodingKeys: String, CodingKey {
        case pvKubernetesIoBindCompleted = "pv.kubernetes.io/bind-completed"
        case pvKubernetesIoBoundByController = "pv.kubernetes.io/bound-by-controller"
        case volumeBetaKubernetesIoStorageProvisioner = "volume.beta.kubernetes.io/storage-provisioner"
        case volumeKubernetesIoStorageProvisioner = "volume.kubernetes.io/storage-provisioner"
    }
}

// MARK: - Labels
struct Labels: Codable {
    let appKubernetesIoComponent, appKubernetesIoInstance, appKubernetesIoName: String

    enum CodingKeys: String, CodingKey {
        case appKubernetesIoComponent = "app.kubernetes.io/component"
        case appKubernetesIoInstance = "app.kubernetes.io/instance"
        case appKubernetesIoName = "app.kubernetes.io/name"
    }
}

// MARK: - ResourcePVC
struct ResourcePVC: Codable {
    let status, storageClass: String
    let capacity: Capacity
    let accessMode: [String]

    enum CodingKeys: String, CodingKey {
        case status, storageClass
        case capacity = "Capacity"
        case accessMode = "access_mode"
    }
}

// MARK: - Capacity
struct Capacity: Codable {
    let storage: String
}

