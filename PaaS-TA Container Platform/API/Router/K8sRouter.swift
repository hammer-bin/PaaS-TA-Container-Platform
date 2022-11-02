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
    
    case deploymnetList(targetUrl: String, authorization: String, namespace: String)
    case deploymentInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    case podList(targetUrl: String, authorization: String, namespace: String)
    
    case pvcList(targetUrl: String, authorization: String, namespace: String)
    case pvcInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    case serviceList(targetUrl: String, authorization: String, namespace: String)
    case ingressList(targetUrl: String, authorization: String, namespace: String)
    
    case configmap(targetUrl: String, authorization: String, namespace: String)
    
    case scList(targetUrl: String, authorization: String, namespace: String)
    case scInfo(targetUrl: String, authorization: String, namespace: String, resourceName: String)
    
    var baseURL: URL {
        return URL(string: K8sAPIClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .deploymnetList:
            return "resource/deployment/list"
        case .podList:
            return "resource/pod/list"
        case .deploymentInfo:
            return "resource/deployment/info"
        case .configmap:
            return "resource/configmap/list"
        case .pvcInfo:
            return "resource/pvc/info"
        case .pvcList:
            return "resource/pvc/list"
        case .serviceList:
            return "resource/service/list"
        case .ingressList:
            return "resource/ingress/list"
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
    
    var parameters: params{
        switch self {
        case let .deploymnetList(targetUrl, authorization, namespace):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            return params
            
        case let .podList(targetUrl, authorization, namespace):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            return params
            
        case let .configmap(targetUrl, authorization, namespace):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            return params
            
        case let .deploymentInfo(targetUrl, authorization, namespace, resourceName):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            params["resource_name"] = resourceName
            return params
            
        case let .pvcInfo(targetUrl, authorization, namespace, resourceName):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            params["resource_name"] = resourceName
            //print(params)
            return params
            
        case let .pvcList(targetUrl, authorization, namespace):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            return params
            
        case let .serviceList(targetUrl, authorization, namespace):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            return params
            
        case let .ingressList(targetUrl, authorization, namespace):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            return params
            
        case let .scList(targetUrl, authorization, namespace):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            return params
            
        case let .scInfo(targetUrl, authorization, namespace, resourceName):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["namespace"] = namespace
            params["resource_name"] = resourceName
            return params
        }
        
        
        
   
    }
    
}
