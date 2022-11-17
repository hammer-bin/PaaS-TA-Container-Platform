//
//  K8sAPIService.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation
import Alamofire
import Combine

enum K8sApiService {
    
    static func PVCList(namespace: String)-> AnyPublisher<[PVCData], AFError> {
        print("K8sApiService = PVCList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return clientPVC(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: PVCResponse.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientPVC(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.pvcList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            
            return K8sAPIClient.shared.session
                .request(K8sRouter.pvcList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    
    static func pvcInfo(namespace: String, resourceName: String)-> AnyPublisher<PVCInfo, AFError> {
        print("K8sApiService = pvcInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.pvcInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: PVCInfo.self)
            .value()
            .map{ receivedValue in
                print("uid :: \(receivedValue.detailPVC.uid)")
                //debugPrint(receivedValue)
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func deployList(namespace: String)-> AnyPublisher<[DeployData], AFError> {
        print("K8sAPIService = deployList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return clientDeploy(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: DeployResponse.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientDeploy(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.deploymentList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            
            return K8sAPIClient.shared.session
                .request(K8sRouter.deploymentList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func deployInfo(namespace: String, resourceName: String)-> AnyPublisher<DeployInfo, AFError> {
        print("K8sApiService = deployInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.deploymentInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: DeployInfo.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func podList(namespace: String)-> AnyPublisher<[PodData], AFError> {
        print("K8sAPIService = podList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return clientPod(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: PodResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientPod(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.podList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            return K8sAPIClient.shared.session
                .request(K8sRouter.podList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func podInfo(namespace: String, resourceName: String)-> AnyPublisher<PodInfo, AFError> {
        print("K8sApiService = podInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.podInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: PodInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func rsList(namespace: String)-> AnyPublisher<[RSData], AFError> {
        print("K8sAPIService = rsList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return clientRS(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: RSResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientRS(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.rsList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            return K8sAPIClient.shared.session
                .request(K8sRouter.rsList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func rsInfo(namespace: String, resourceName: String)-> AnyPublisher<RSInfo, AFError> {
        print("K8sApiService = rsInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.rsInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: RSInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func serviceList(namespace: String)-> AnyPublisher<[ServiceData], AFError> {
        print("K8sAPIService = serviceList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl

        return clientService(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: ServiceResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientService(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.serviceList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            
            return K8sAPIClient.shared.session
                .request(K8sRouter.serviceList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func serviceInfo(namespace: String, resourceName: String)-> AnyPublisher<ServiceInfo, AFError> {
        print("K8sApiService = serviceInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.serviceInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: ServiceInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func configmapList(namespace: String)-> AnyPublisher<[ConfigmapData], AFError> {
        print("K8sAPIService = configmapList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl

        return clientConfigmap(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: ConfigmapResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientConfigmap(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.configmapList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            return K8sAPIClient.shared.session
                .request(K8sRouter.configmapList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func configmapInfo(namespace: String, resourceName: String)-> AnyPublisher<ConfigmapInfo, AFError> {
        print("K8sApiService = configmapInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.configmapInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: ConfigmapInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func secretList(namespace: String)-> AnyPublisher<[SecretData], AFError> {
        print("K8sAPIService = secretList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl

        return clientSecret(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: SecretResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientSecret(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.secretList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            return K8sAPIClient.shared.session
                .request(K8sRouter.secretList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func secretInfo(namespace: String, resourceName: String)-> AnyPublisher<SecretInfo, AFError> {
        print("K8sApiService = configmapInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.secretInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: SecretInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func PVList()-> AnyPublisher<[PVData], AFError> {
        print("K8sApiService = PVList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        print("storedApiUrl :: \(storedApiUrl)")
        return K8sAPIClient.shared.session
            .request(K8sAdminRouter.pvList(targetUrl: storedApiUrl, authorization: storedTokenData))
            .publishDecodable(type: PVResponse.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    static func pvInfo(resourceName: String)-> AnyPublisher<PVInfo, AFError> {
        print("K8sApiService = pvInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sAdminRouter.pvInfo(targetUrl: storedApiUrl, authorization: storedTokenData, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: PVInfo.self)
            .value()
            .map{ receivedValue in
                //print("uid :: \(receivedValue.detailPVC.uid)")
                //debugPrint(receivedValue)
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func IngressList(namespace: String)-> AnyPublisher<[IngressData], AFError> {
        print("K8sApiService = IngressList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return clientIngress(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: IngressResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientIngress(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.ingressList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            
            return K8sAPIClient.shared.session
                .request(K8sRouter.ingressList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func ingressInfo(namespace: String, resourceName: String)-> AnyPublisher<IngressInfo, AFError> {
        print("K8sApiService = ingressInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.ingressInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: IngressInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func namespaceList()-> AnyPublisher<[NamespaceData], AFError> {
        print("K8sApiService = namespaceList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sAdminRouter.namespaceList(targetUrl: storedApiUrl, authorization: storedTokenData))
            .publishDecodable(type: NamespaceResponse.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    static func clusterMetricInfo()-> AnyPublisher<ClusterMetricInfo, AFError> {
        print("K8sApiService = clusterMetricInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sAdminRouter.clusterMetricInfo(targetUrl: storedApiUrl, authorization: storedTokenData))
            .validate(statusCode: 200...400)
            .publishDecodable(type: ClusterMetricInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func namespaceMetricInfo()-> AnyPublisher<NamespaceMetricInfo, AFError> {
        print("K8sApiService = namespaceMetricInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        let namespace = UserDefaultManager.shared.getNamespace()

        return K8sAPIClient.shared.session
            .request(K8sRouter.namespaceMetricInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
            .validate(statusCode: 200...400)
            .publishDecodable(type: NamespaceMetricInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func scList(namespace: String)-> AnyPublisher<[SCData], AFError> {
        print("K8sApiService = scList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return clientSC(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: SCResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientSC(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.scList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            
            return K8sAPIClient.shared.session
                .request(K8sRouter.scList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func scInfo(nemespace: String, resourceName: String)-> AnyPublisher<SCInfo, AFError> {
        print("K8sApiService = scInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.scInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: nemespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: SCInfo.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func resourceQuotaList(namespace: String)-> AnyPublisher<[ResourceQuotaData], AFError> {
        print("K8sAPIService = resourceQuotaList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl

        return clientResourceQuota(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: ResourceQuotaResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientResourceQuota(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.resourceQuotaList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            return K8sAPIClient.shared.session
                .request(K8sRouter.resourceQuotaList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func resourceQuotaInfo(namespace: String, resourceName: String)-> AnyPublisher<ResourceQuotaInfo, AFError> {
        print("K8sApiService = resourceQuotaInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.resourceQuotaInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: ResourceQuotaInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func limitRangeList(namespace: String)-> AnyPublisher<[LimitRangeData], AFError> {
        print("K8sAPIService = limitRangeList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl

        return clientLimitRange(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: LimitRangeResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data ?? []
            }
            .eraseToAnyPublisher()
    }
    
    fileprivate static func clientLimitRange(_ storedApiUrl: String, _ storedTokenData: String, _ namespace: String) -> DataRequest {
        if namespace == "All" {
            return K8sAPIClient.shared.session
                .request(K8sAdminRouter.limitRangeList(targetUrl: storedApiUrl, authorization: storedTokenData))
        } else {
            return K8sAPIClient.shared.session
                .request(K8sRouter.limitRangeList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
        }
    }
    
    static func limitRangeInfo(namespace: String, resourceName: String)-> AnyPublisher<LimitRangeInfo, AFError> {
        print("K8sApiService = limitRangeInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.limitRangeInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: LimitRangeInfo.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
}
