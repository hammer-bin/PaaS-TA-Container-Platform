//
//  K8sAPIClient.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import Foundation
import Alamofire

final class K8sAPIClient {
    static let shared = K8sAPIClient()
    
    static let BASE_URL = "http://15.164.195.107:30295/"
    
    let interceptors = Interceptor(interceptors: [ BaseInterceptor() ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("K8sAPIClient - init() called")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
