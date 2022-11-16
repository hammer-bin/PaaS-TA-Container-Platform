//
//  UserDefaultManager.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation

class UserDefaultManager {
    enum Key: String, CaseIterable {
        case refreshToken, accessToken, k8sToken, apiUrl, isAdmin, k8sName, nsName
    }
    enum userKey: String, CaseIterable {
        case userId, userName, clusterName, apiUrl, k8sToken, isAdmin
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
    func setTokens(accessToken: String, refreshToken: String, k8sToken: String, apiUrl: String, isAdmin: Bool, k8sName: String, nsName: String){
        print("UserDefaultManger - setToken() called")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.set(k8sToken, forKey: Key.k8sToken.rawValue)
        UserDefaults.standard.set(apiUrl, forKey: Key.apiUrl.rawValue)
        UserDefaults.standard.set(isAdmin, forKey: Key.isAdmin.rawValue)
        UserDefaults.standard.set(k8sName, forKey: Key.k8sName.rawValue)
        UserDefaults.standard.set(nsName, forKey: Key.nsName.rawValue)
        UserDefaults.standard.synchronize()
    }
    
//    func setUserData(userId: String, userName: String, clusterName: String, apiUrl: String, k8sToken: String, isAdmin: Bool) {
//        UserDefaults.standard.set(userId, forKey: userKey.userId.rawValue)
//        UserDefaults.standard.set(userName, forKey: userKey.userName.rawValue)
//        UserDefaults.standard.set(clusterName, forKey: userKey.clusterName.rawValue)
//        UserDefaults.standard.set(apiUrl, forKey: userKey.apiUrl.rawValue)
//        UserDefaults.standard.set(k8sToken, forKey: userKey.k8sToken.rawValue)
//        UserDefaults.standard.set(isAdmin, forKey: userKey.isAdmin.rawValue)
//    }
    
    //func getUserData()->
    
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
    
    func getIsAdmin()->Bool{
        return UserDefaults.standard.bool(forKey: Key.isAdmin.rawValue)
    }
    
    func getK8sName()->String {
        return UserDefaults.standard.string(forKey: Key.k8sName.rawValue) ?? ""
    }
    
    func getNamespace()->String {
        return UserDefaults.standard.string(forKey: Key.nsName.rawValue) ?? ""
    }
}
