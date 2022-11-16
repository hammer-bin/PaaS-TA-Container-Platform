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
    
    case deploymentList(targetUrl: String, authorization: String)
    case podList(targetUrl: String, authorization: String)
    case deploymentInfo(targetUrl: String, authorization: String, resourceName: String)
    case rsList(targetUrl: String, authorization: String)
    case rsInfo(targetUrl: String, authorization: String, resourceName: String)
    case configmapList(targetUrl: String, authorization: String)
    case configmapInfo(targetUrl: String, authorization: String, resourceName: String)
    case pvcList(targetUrl: String, authorization: String)
    case pvcInfo(targetUrl: String, authorization: String, resourceName: String)
    case serviceList(targetUrl: String, authorization: String)
    case serviceInfo(targetUrl: String, authorization: String, resourceName: String)
    case ingressList(targetUrl: String, authorization: String)
    case ingressInfo(targetUrl: String, authorization: String, resourceName: String)
    case pvList(targetUrl: String, authorization: String)
    case pvInfo(targetUrl: String, authorization: String, resourceName: String)
    case namespaceList(targetUrl: String, authorization: String)
    case clusterMetricInfo(targetUrl: String, authorization: String)
    
    case scList(targetUrl: String, authorization: String)
    case scInfo(targetUrl: String, authorization: String, resourceName: String)
    
    var baseURL: URL {
        return URL(string: K8sAPIClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .deploymentList:
            return "resource/deployment/list"
        case .podList:
            return "resource/pod/list"
        case .deploymentInfo:
            return "resource/deployment/info"
        case .rsList:
            return "resource/rs/list"
        case .rsInfo:
            return "resource/rs/info"
        case .configmapList:
            return "resource/configmap/list"
        case .configmapInfo:
            return "resource/configmap/info"
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
        case .pvList:
            return "resource/pv/list"
        case .pvInfo:
            return "resource/pv/info"
        case .namespaceList:
            return "resource/namespace/list"
        case .clusterMetricInfo:
            return "metrics/cluster/count"
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
    
    fileprivate func listParam(_ targetUrl: String, _ authorization: String) -> K8sAdminRouter.params {
        var params = params()
        params["target_url"] = targetUrl
        params["authorization"] = authorization
        return params
    }
    
    fileprivate func infoParam(_ targetUrl: String, _ authorization: String, _ resourceName: String) -> K8sAdminRouter.params {
        var params = params()
        params["target_url"] = targetUrl
        params["authorization"] = authorization
        params["resource_name"] = resourceName
        return params
    }
    
    var parameters: params{
        switch self {
        case let .deploymentList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .podList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .rsList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
        case let .rsInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        case let .configmapList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
        case let .configmapInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        case let .deploymentInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        case let .pvcInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        case let .pvcList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .serviceList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .serviceInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        case let .ingressList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .ingressInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        case let .pvList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .pvInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        case let .namespaceList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .clusterMetricInfo(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .scList(targetUrl, authorization):
            return listParam(targetUrl, authorization)
            
        case let .scInfo(targetUrl, authorization, resourceName):
            return infoParam(targetUrl, authorization, resourceName)
            
        }
        
   
    }
    
}
