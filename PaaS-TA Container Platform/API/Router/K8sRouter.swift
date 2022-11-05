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
    
    case pvcList(targetUrl: String, authorization: String, namespace: String)
    case pvcInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case serviceList(targetUrl: String, authorization: String, namespace: String)
    case serviceInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    case ingressList(targetUrl: String, authorization: String, namespace: String)
    case ingressInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case configmap(targetUrl: String, authorization: String, namespace: String)
    
    case scList(targetUrl: String, authorization: String, namespace: String)
    case scInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
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
        case .configmap:
            return "resource/configmap/list"
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
            
        case let .configmap(targetUrl, authorization, namespace):
            return listParam(targetUrl, authorization, namespace)
      
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
        }
        
        
        
   
    }
    
}
