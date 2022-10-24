//
//  UserDefaultManager.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation

class UserDefaultManager {
    enum Key: String, CaseIterable {
        case refreshToken, accessToken, k8sToken, apiUrl
    }
    
    static let shared: UserDefaultManager = {
        return UserDefaultManager()
    }()
    
    // 저장된 모든 데이터 지우기
    func clearAll() {
        print("UserDefaultManager = clearAll() called")
        Key.allCases.forEach{ UserDefaults.standard.removeObject(forKey: $0.rawValue)}
    }
    
    // 토큰 저장. 영구적데이터는 KeyChain에 저장하는것이 좋다.
    func setTokens(accessToken: String, refreshToken: String, k8sToken: String, apiUrl: String){
        print("UserDefaultManger - setToken() called")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.set(k8sToken, forKey: Key.k8sToken.rawValue)
        UserDefaults.standard.set(apiUrl, forKey: Key.apiUrl.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    // Auth Token 가져오기
    func getTokens()->TokenData{
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue) ?? ""
        return TokenData(accessToken: accessToken, refreshToken: refreshToken)
    }
    
    // K8s Token 가져오기
    func getK8sToken()->K8sData{
        let k8sToken = UserDefaults.standard.string(forKey: Key.k8sToken.rawValue) ?? ""
        let apiUrl = UserDefaults.standard.string(forKey: Key.apiUrl.rawValue) ?? ""
        return K8sData(k8sToken: k8sToken, apiUrl: apiUrl)
    }
}
