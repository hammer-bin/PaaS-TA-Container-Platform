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
    
    static let BASE_URL = "http://223.255.205.62:30266/"
    
    let interceptors = Interceptor(interceptors: [ BaseInterceptor() ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
