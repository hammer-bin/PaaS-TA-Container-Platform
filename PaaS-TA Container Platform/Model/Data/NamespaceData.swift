//
//  NamespaceData.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/20.
//

import Foundation

struct NamespaceData: Codable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let labels: [String]
    let status: Status
    let createdTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case labels = "Labels"
        case status
        case createdTime = "created_time"
    }
    
    struct Labels: Codable {
        let kubernetesIoMetadataName: String
        let appKubernetesIoInstance, appKubernetesIoName, istioInjection, istioOperatorManaged: String?
        let appKubernetesIoComponent, appKubernetesIoVersion, eventingKnativeDevRelease, kustomizeComponent: String?
        let servingKnativeDevRelease, controlPlane, appKubernetesIoPartOf, katibKubeflowOrgMetricsCollectorInjection: String?
        let pipelinesKubeflowOrgEnabled, servingKubeflowOrgInferenceservice, olmOperatorgroupUid756F1C136E9543Ba888301A6Fe516Bb1, podSecurityKubernetesIoEnforce: String?
        let podSecurityKubernetesIoEnforceVersion: String?

        enum CodingKeys: String, CodingKey {
            case kubernetesIoMetadataName = "kubernetes.io/metadata.name"
            case appKubernetesIoInstance = "app.kubernetes.io/instance"
            case appKubernetesIoName = "app.kubernetes.io/name"
            case istioInjection = "istio-injection"
            case istioOperatorManaged = "istio-operator-managed"
            case appKubernetesIoComponent = "app.kubernetes.io/component"
            case appKubernetesIoVersion = "app.kubernetes.io/version"
            case eventingKnativeDevRelease = "eventing.knative.dev/release"
            case kustomizeComponent = "kustomize.component"
            case servingKnativeDevRelease = "serving.knative.dev/release"
            case controlPlane = "control-plane"
            case appKubernetesIoPartOf = "app.kubernetes.io/part-of"
            case katibKubeflowOrgMetricsCollectorInjection = "katib.kubeflow.org/metrics-collector-injection"
            case pipelinesKubeflowOrgEnabled = "pipelines.kubeflow.org/enabled"
            case servingKubeflowOrgInferenceservice = "serving.kubeflow.org/inferenceservice"
            case olmOperatorgroupUid756F1C136E9543Ba888301A6Fe516Bb1 = "olm.operatorgroup.uid/756f1c13-6e95-43ba-8883-01a6fe516bb1"
            case podSecurityKubernetesIoEnforce = "pod-security.kubernetes.io/enforce"
            case podSecurityKubernetesIoEnforceVersion = "pod-security.kubernetes.io/enforce-version"
        }
    }
    
    enum Status: String, Codable {
        case active = "Active"
    }
}
