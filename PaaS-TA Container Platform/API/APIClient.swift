//
//  APIClient.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation
import Alamofire

final class APIClient {
    static let shared = APIClient()
    
    static let BASE_URL = "http://15.164.195.107:30295/"
    
    let interceptors = Interceptor(interceptors: [ BaseInterceptor() ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
