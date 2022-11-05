//
//  UserVM.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation
import Alamofire
import Combine

class UserVM: ObservableObject {

     // MARK: - Properties
    var subscription = Set<AnyCancellable>()
    
    @Published var loggedInUser: UserData? = nil
    
    // Login Properties..
    @Published var email: String = ""
    @Published var apiUrl: String = ""
    @Published var k8sToken: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // Cluster 관리자 여부, false일 경우 namespace 사용자
    @Published var isClusterAdmin: Bool = false
    @Published var isLoading: Bool = false
    
    //회원가입 완료 이벤트
    var registrationSuccess = PassthroughSubject<(), Never>()
    
    // 회원로그인 완료 이벤트
    var loginSuccess = PassthroughSubject<(), Never>()
    
    //회원가입 하기
    func register(name: String, email: String, password: String, apiUrl: String, k8SToken: String) {
        print("UserVM: register() called")
        AuthAPIService.register(name: name, email: email, password: password, apiUrl: apiUrl, k8SToken: k8SToken)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserVM completion: \(completion)")
            } receiveValue: { (receivedUser: UserData) in
                self.loggedInUser = receivedUser
                self.registrationSuccess.send()
            }.store(in: &subscription)
    }
    
    //로그인 하기
    func login(email: String, password: String) {
        print("UserVM: register() called")
        
        AuthAPIService.login(email: email, password: password)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserVM completion: \(completion)")
            } receiveValue: { (receivedUser: UserData) in
                self.loggedInUser = receivedUser
                self.loginSuccess.send()
            }.store(in: &subscription)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading.toggle()
        }
        
    }
    
    // Login Call...
    func Login(){
        // Do Action Here...
    }
    
    func Register(){
        // Do Action Here...
    }
    
    func ForgetPassword() {
        // Do Action Here...
    }
}

