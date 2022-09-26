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
    //static func login(email: String, password: String)->
    //회원가입
    static func register(name: String, email: String, password: String)-> AnyPublisher<UserData, AFError> {
        print("AuthAPIService = register() called")
        
        return APIClient.shared.session
            .request(AuthRouter.register(name: name, email: email, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults, keychain
                print(receivedValue.token.accessToken)
                print(receivedValue.token.refreshToken)
                UserDefaultManager.shared.setTokens(accessToken: receivedValue.token.accessToken, refreshToken: receivedValue.token.refreshToken, k8sToken: receivedValue.token.k8sToken)
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    //로그인
    static func login(email: String, password: String)-> AnyPublisher<UserData, AFError> {
        print("AuthAPIService = register() called")
        
        return APIClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults, keychain
                UserDefaultManager.shared.setTokens(accessToken: receivedValue.token.accessToken, refreshToken: receivedValue.token.refreshToken, k8sToken: receivedValue.token.k8sToken)
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
}
