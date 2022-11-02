//
//  ClusterMetricInfo.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/29.
//

import Foundation

struct ClusterMetricInfo: Codable {
    let kubeletVersion: String
    let nodeCnt, nodeTCnt, nameSpaceCnt, nameSpaceTCnt: CGFloat
    let pvCnt, pvTCnt, pvcCnt, pvcTCnt: CGFloat
    let podCnt, podTCnt : CGFloat
    let cpuRatio, memRatio : CGFloat
    let updateTime: String

    enum CodingKeys: String, CodingKey {
        case kubeletVersion = "KubeletVersion"
        case nodeCnt = "NodeCnt"
        case nodeTCnt = "node_t_cnt"
        case nameSpaceCnt = "NameSpaceCnt"
        case nameSpaceTCnt = "name_space_t_cnt"
        case pvCnt = "PvCnt"
        case pvTCnt = "pv_t_cnt"
        case pvcCnt = "PvcCnt"
        case pvcTCnt = "pvc_t_cnt"
        case podCnt = "PodCnt"
        case podTCnt = "pod_t_cnt"
        case cpuRatio = "CpuRatio"
        case memRatio = "MemRatio"
        case updateTime = "UpdateTime"
    }
}
