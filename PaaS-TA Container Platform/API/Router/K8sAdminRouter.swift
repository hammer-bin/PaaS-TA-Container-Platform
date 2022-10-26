//
//  K8sAdminRouter.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/18.
//

import Foundation
import Alamofire

enum K8sAdminRouter: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        return request
    }
    
    case deploymnetList(targetUrl: String, authorization: String)
    case podList(targetUrl: String, authorization: String)
    case deploymentInfo(targetUrl: String, authorization: String, resourceName: String)
    case configmap(targetUrl: String, authorization: String)
    case pvcList(targetUrl: String, authorization: String)
    case pvcInfo(targetUrl: String, authorization: String, resourceName: String)
    case serviceList(targetUrl: String, authorization: String)
    case pvList(targetUrl: String, authorization: String)
    case namespaceList(targetUrl: String, authorization: String)
    
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
        case .pvList:
            return "resource/pv/list"
        case .namespaceList:
            return "resource/namespace/list"
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
        case let .deploymnetList(targetUrl, authorization):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            return params
            
        case let .podList(targetUrl, authorization):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            return params
            
        case let .configmap(targetUrl, authorization):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            return params
            
        case let .deploymentInfo(targetUrl, authorization, resourceName):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["resource_name"] = resourceName
            return params
            
        case let .pvcInfo(targetUrl, authorization, resourceName):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            params["resource_name"] = resourceName
            return params
            
        case let .pvcList(targetUrl, authorization):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            return params
            
        case let .serviceList(targetUrl, authorization):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            return params
            
        case let .pvList(targetUrl, authorization):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            return params
            
        case let .namespaceList(targetUrl, authorization):
            var params = params()
            params["target_url"] = targetUrl
            params["authorization"] = authorization
            return params
            
        }
        
   
    }
    
}