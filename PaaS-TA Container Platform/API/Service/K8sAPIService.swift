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
    
    static func PVCList()-> AnyPublisher<[PVCData], AFError> {
        print("K8sApiService = PVCList() called")
        let targetUrl = "https://15.164.195.107:6443"
        let authorization = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImNJaTZLT2Y1WU1XY2Q5a3NvbFEwdVRWal9GRm5jVzRyelppSWVKNXgtTVEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrOHNhZG1pbi10b2tlbi1ucG13ZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJrOHNhZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijg3YTUwODYxLTFlODUtNGU4My04YTJlLTk4ZTdlZGVkYTBjMiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTprOHNhZG1pbiJ9.Ygy9DRQbSoozhIfWizCDkUhcTWf7V_g0611stsHSzAj13I2p4WtLYgyS1tMnOf64TcV3y9ehWxCnSUPB4p0-Bc5lc6CsJ12DQ8pr9g0sSs6y5Nmb28MBY6xxrQEYtt7ahukDabFXVWxjxEOQqaHAtwNiuOFkAFRId0aaBSoaldhvfGdNiuxKV1LSTWpE9LWhaaOa3z4wmiAY5vZBMUGHUIfn3-QpFHaxAbKQxsCFaoERcQo3yQ6lo7uPVs3X64MU7dGzVAqzLZcpk63ra39vJPCZzZOeQUyv2cSlop8DRQKM7xoaVxYJ75j26WaD9h6cS5nbSfjsLCxSidIPtspKBQ"
        let namespace = "harbor"
        return K8sAPIClient.shared.session
            .request(K8sRouter.pvcList(targetUrl: targetUrl, authorization: authorization, namespace: namespace))
            .publishDecodable(type: PVCResponse.self)
            .value()
            .map{ receivedValue in
                debugPrint(receivedValue)
                return receivedValue.data
            }
            .eraseToAnyPublisher()
    }
    
    
    static func pvcInfo()-> AnyPublisher<PVCInfo, AFError> {
        print("K8sApiService = pvcInfo() called")
        let targetUrl = "https://15.164.195.107:6443"
        let authorization = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImNJaTZLT2Y1WU1XY2Q5a3NvbFEwdVRWal9GRm5jVzRyelppSWVKNXgtTVEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrOHNhZG1pbi10b2tlbi1ucG13ZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJrOHNhZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijg3YTUwODYxLTFlODUtNGU4My04YTJlLTk4ZTdlZGVkYTBjMiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTprOHNhZG1pbiJ9.Ygy9DRQbSoozhIfWizCDkUhcTWf7V_g0611stsHSzAj13I2p4WtLYgyS1tMnOf64TcV3y9ehWxCnSUPB4p0-Bc5lc6CsJ12DQ8pr9g0sSs6y5Nmb28MBY6xxrQEYtt7ahukDabFXVWxjxEOQqaHAtwNiuOFkAFRId0aaBSoaldhvfGdNiuxKV1LSTWpE9LWhaaOa3z4wmiAY5vZBMUGHUIfn3-QpFHaxAbKQxsCFaoERcQo3yQ6lo7uPVs3X64MU7dGzVAqzLZcpk63ra39vJPCZzZOeQUyv2cSlop8DRQKM7xoaVxYJ75j26WaD9h6cS5nbSfjsLCxSidIPtspKBQ"
        let namespace = "default"
        let resourceName = "data-mariadb-0"
        return K8sAPIClient.shared.session
            .request(K8sRouter.pvcInfo(targetUrl: targetUrl, authorization: authorization, namespace: namespace, resourceName: resourceName))
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
    
}
