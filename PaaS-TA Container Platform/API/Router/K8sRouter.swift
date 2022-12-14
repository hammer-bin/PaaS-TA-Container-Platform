//
//  K8sRouter.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation
import Alamofire

enum K8sRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        return request
    }
    
    case deploymentList(targetUrl: String, authorization: String, namespace: String)
    case deploymentInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    case podList(targetUrl: String, authorization: String, namespace: String)
    case podInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    case rsList(targetUrl: String, authorization: String, namespace: String)
    case rsInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case pvcList(targetUrl: String, authorization: String, namespace: String)
    case pvcInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case serviceList(targetUrl: String, authorization: String, namespace: String)
    case serviceInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    case ingressList(targetUrl: String, authorization: String, namespace: String)
    case ingressInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case configmapList(targetUrl: String, authorization: String, namespace: String)
    case configmapInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    case secretList(targetUrl: String, authorization: String, namespace: String)
    case secretInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case scList(targetUrl: String, authorization: String, namespace: String)
    case scInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case resourceQuotaList(targetUrl: String, authorization: String, namespace: String)
    case resourceQuotaInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    case limitRangeList(targetUrl: String, authorization: String, namespace: String)
    case limitRangeInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case namespaceMetricInfo(targetUrl: String, authorization: String, namespace: String)
    
    var baseURL: URL {
        return URL(string: K8sAPIClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .deploymentList:
            return "resource/deployment/list"
        case .deploymentInfo:
            return "resource/deployment/info"
        case .podList:
            return "resource/pod/list"
        case .podInfo:
            return "resource/pod/info"
        case .rsList:
            return "resource/rs/list"
        case .rsInfo:
            return "resource/rs/info"
        case .configmapList:
            return "resource/configmap/list"
        case .configmapInfo:
            return "resource/configmap/info"
        case .secretList:
            return "resource/secret/list"
        case .secretInfo:
            return "resource/secret/info"
        case .pvcInfo:
            return "resource/pvc/info"
        case .pvcList:
            return "resource/pvc/list"
        case .serviceList:
            return "resource/service/list"
        case .serviceInfo:
            return "resource/service/info"
        case .ingressList:
            return "resource/ingress/list"
        case .ingressInfo:
            return "resource/ingress/info"
        case .scList:
            return "resource/sc/list"
        case .scInfo:
            return "resource/sc/info"
        case .resourceQuotaList:
            return "resource/resourcequota/list"
        case .resourceQuotaInfo:
            return "resource/resourcequota/info"
        case .limitRangeList:
            return "resource/limitrange/list"
        case .limitRangeInfo:
            return "resource/limitrange/info"
        case .namespaceMetricInfo:
            return "metrics/namespace/count"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    typealias params = [String : String]
    
    fileprivate func listParam(_ targetUrl: String, _ authorization: String, _ namespace: String) -> K8sRouter.params {
        var params = params()
        params["target_url"] = targetUrl
        params["authorization"] = authorization
        params["namespace"] = namespace
        return params
    }
    
    fileprivate func infoParam(_ targetUrl: String, _ authorization: String, _ namespace: String, _ resourceName: String) -> K8sRouter.params {
        var params = params()
        params["target_url"] = targetUrl
        params["authorization"] = authorization
        params["namespace"] = namespace
        params["resource_name"] = resourceName
        return params
    }
    
    var parameters: params{
        switch self {
        case let .deploymentList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .deploymentInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .podList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .podInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .rsList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .rsInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .configmapList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .configmapInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .secretList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .secretInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
      
        case let .pvcList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .pvcInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .serviceList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .serviceInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .ingressList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .ingressInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .scList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .scInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .resourceQuotaList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .resourceQuotaInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .limitRangeList(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        case let .limitRangeInfo(targetUrl, authorization, namespace, resourceName):
            return infoParam(targetUrl, authorization, namespace, resourceName)
            
        case let .namespaceMetricInfo(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
        }
        
        
        
   
    }
    
}
