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
                return receivedValue.data
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
    
    static func deployList()-> AnyPublisher<[DeployData], AFError> {
        print("K8sAPIService = deployList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        let namespace = "harbor"
        return K8sAPIClient.shared.session
            .request(K8sRouter.deploymnetList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
            .publishDecodable(type: DeployResponse.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.data
            }
            .eraseToAnyPublisher()
    }
    
    static func deployInfo(nemespace: String, resourceName: String)-> AnyPublisher<DeployInfo, AFError> {
        print("K8sApiService = pvcInfo() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return K8sAPIClient.shared.session
            .request(K8sRouter.deploymentInfo(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: nemespace, resourceName: resourceName))
            .validate(statusCode: 200...400)
            .publishDecodable(type: DeployInfo.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func podList()-> AnyPublisher<[PodData], AFError> {
        print("K8sAPIService = podList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        let namespace = "harbor"
        return K8sAPIClient.shared.session
            .request(K8sRouter.podList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
            .publishDecodable(type: PodResponse.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.data
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
                return receivedValue.data
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
        return K8sAPIClient.shared.session
            .request(K8sRouter.ingressList(targetUrl: storedApiUrl, authorization: storedTokenData, namespace: namespace))
            .publishDecodable(type: IngressResponse.self)
            .value()
            .map{ receivedValue in
                //debugPrint(receivedValue)
                return receivedValue.data
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
                return receivedValue.data
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
    
    static func scList(namespace: String)-> AnyPublisher<[SCData], AFError> {
        print("K8sApiService = scList() called")
        
        let storedTokenData = UserDefaultManager.shared.getK8sToken().k8sToken
        let storedApiUrl = UserDefaultManager.shared.getK8sToken().apiUrl
        return clientSC(storedApiUrl, storedTokenData, namespace)
            .publishDecodable(type: SCResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue.data
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
    
}
