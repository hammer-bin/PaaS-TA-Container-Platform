//
//  AuthRouter.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation
import Alamofire
import UIKit

// 인증 라우터
// 회원가입, 로그인, 토큰갱신
enum AuthRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        
        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        
        return request
    }
    
    
    case register(name: String, email: String, password: String, apiUrl: String, k8sToken: String, isAdmin: Bool)
    case login(email: String, password: String)
    case tokenRefresh
    
    var baseURL: URL {
        return URL(string: APIClient.BASE_URL)!
    }
    
    var endPoint: String{
        switch self {
        case .register:
            return "register/user"
        case .login:
            return "login"
        case .tokenRefresh:
            return "user/token-refresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .post
        }
    }
    
    var parameters: Parameters{
        switch self {
        case let .login(email, password):
            var params = Parameters()
            params["user_id"] = email
            params["user_password"] = password
            return params
        
        
        case .register(let name, let email, let password, let apiUrl, let k8sToken, let isAdmin):
            var params = Parameters()
            params["user_name"] = name
            params["user_id"] = email
            params["user_password"] = password
            params["api_url"] = apiUrl
            params["k8S_token"] = k8sToken
            params["is_admin"] = isAdmin
            return params
            
        case .tokenRefresh:
            var params = Parameters()
            let tokenData = UserDefaultManager.shared.getTokens()
            params["refresh_token"] = tokenData.refreshToken
            return params
        }
        
    }
}
