//
//  AuthAPIService.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation
import Combine
import Alamofire

//인증관련 api 호출
enum AuthAPIService {
    //회원가입
    static func register(name: String, email: String, password: String, apiUrl: String, k8SToken: String, isAdmin: Bool, k8sName: String, nsName: String)-> AnyPublisher<UserData, AFError> {
        print("AuthAPIService = register() called")
        print("email:: \(email)")
        print("password:: \(password)")
        print("apiUrl:: \(apiUrl)")
        print("k8SToken:: \(k8SToken)")
        print("isAdmin:: \(isAdmin)")
        return APIClient.shared.session
            .request(AuthRouter.register(name: name, email: email, password: password, apiUrl: apiUrl, k8sToken: k8SToken, isAdmin: isAdmin, k8sName: k8sName, NSName: nsName))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults, keychain
                print(receivedValue.token.accessToken)
                print(receivedValue.token.refreshToken)
                UserDefaultManager.shared.setTokens(accessToken: receivedValue.token.accessToken, refreshToken: receivedValue.token.refreshToken, k8sToken: receivedValue.user.k8sToken, apiUrl: receivedValue.user.apiUrl, isAdmin: receivedValue.user.isAdmin, k8sName: receivedValue.user.k8sName, nsName: receivedValue.user.nsName, userId: receivedValue.user.userID)
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    //로그인
    static func login(email: String, password: String)-> AnyPublisher<UserData, AFError> {
        print("AuthAPIService = login() called")
        print(email)
        print(password)
        return APIClient.shared.session
            .request(AuthRouter.login(email: email, password: password, deviceToken: UserDefaultManager.shared.getDeviceToken()))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                print(receivedValue)
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults, keychain
                UserDefaultManager.shared.setTokens(accessToken: receivedValue.token.accessToken, refreshToken: receivedValue.token.refreshToken, k8sToken: receivedValue.user.k8sToken, apiUrl: receivedValue.user.apiUrl, isAdmin: receivedValue.user.isAdmin, k8sName: receivedValue.user.k8sName, nsName: receivedValue.user.nsName, userId: receivedValue.user.userID)
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    static func logout()-> AnyPublisher<UserData, AFError> {
        print("AuthAPIService = logout() called")
        return APIClient.shared.session
            .request(AuthRouter.logout(email: UserDefaultManager.shared.getUserID(), deviceToken: UserDefaultManager.shared.getDeviceToken()))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                print(receivedValue)
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    //APNs 디바이스 토큰 저장
    static func updateDeviceToken(token: String)-> AnyPublisher<ApnsTokenData, AFError> {
        print("AuthAPIService = updateDeviceToken() called")

        return APIClient.shared.session
            .request(AuthRouter.updateDeviceToken(token: token))
            .publishDecodable(type: ApnsTokenData.self)
            .value()
            .map{ receivedValue in
                print(receivedValue)
                return receivedValue
            }.eraseToAnyPublisher()
    }
}
