//
//  NamespaceMetricInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import Foundation

struct NamespaceMetricInfo: Codable {
    var podCnt, podTCnt, deployCnt, deployTCnt: CGFloat
    var replicaSetCnt, replicaSetTCnt: CGFloat
    var pvcCnt, pvcTCnt: CGFloat
    var podRatio, deployRatio, replicaSetRatio, pvcRatio: CGFloat

    enum CodingKeys: String, CodingKey {
        case podCnt = "pod_cnt"
        case podTCnt = "pod_t_cnt"
        case deployCnt = "deploy_cnt"
        case deployTCnt = "deploy_t_cnt"
        case replicaSetCnt = "replica_set_cnt"
        case replicaSetTCnt = "replica_set_t_cnt"
        case pvcCnt = "pvc_cnt"
        case pvcTCnt = "pvc_t_cnt"
        case podRatio = "pod_ratio"
        case deployRatio = "deploy_ratio"
        case replicaSetRatio = "replica_set_ratio"
        case pvcRatio = "pvc_ratio"
    }
}
