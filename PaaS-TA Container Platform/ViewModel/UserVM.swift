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
    @Published var email = "" {
        didSet {
            if self.email.isEmpty {
                self.emailCharError = "Required"
            } else if !self.email.isValidEmail() {
                self.emailCharError = "Invalied email"
            } else {
                self.emailCharError = ""
            }
        }
    }
    @Published var apiUrl: String = ""
    @Published var k8sToken: String = ""
    @Published var k8sName: String = ""
    @Published var nsName: String = ""
    
    @Published var password = "" {
        didSet {
            self.isValidPassword()
        }
    }
    
    @Published var emailCharError = ""
    @Published var passwordCharError = ""
    
    private func isValidPassword() {
        guard !self.password.isEmpty else {
            self.passwordCharError = "Required"
            return
        }
        
        let setPassError = self.password.isPassword() == false
        
        if setPassError {
            if self.password.count < 6 {
                self.passwordCharError = "Must be at least 6 characters"
                return
            }
            
            if !self.password.isUpperCase() {
                self.passwordCharError = "Must contain at least one uppercase."
                return
            }
            
            if !self.password.isLowerCase() {
                self.passwordCharError = "Must contain at lease one lowercase."
                return
            }
            
            if !self.password.containnsCharacter() {
                self.passwordCharError = "Must contain at least one special character"
                return
            }
            
            if !self.password.containsDigit() {
                self.passwordCharError = "Must contain at least one digit"
                return
            }
        }
        else {
            self.passwordCharError = ""
        }
    }
    
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password = "" {
        didSet {
            if self.password != self.re_Enter_Password {
                self.equalsPasswordError = "Require same password"
            } else if self.password == self.re_Enter_Password && self.re_Enter_Password.count > 0 {
                self.equalsPasswordError = "OK"
            } else {
                self.equalsPasswordError = ""
            }
        }
    }
    @Published var equalsPasswordError = ""
    @Published var showReEnterPassword: Bool = false
    
    // Cluster 관리자 여부, false일 경우 namespace 사용자
    @Published var isClusterAdmin: Bool = false
    @Published var isLoading: Bool = false
    @Published var userNamespace: String = "All"
    
    //회원가입 완료 이벤트
    var registrationSuccess = PassthroughSubject<(), Never>()
    
    // 회원로그인 완료 이벤트
    var loginSuccess = PassthroughSubject<(), Never>()
    
    var loginFailed = PassthroughSubject<(), Never>()
    
    //회원가입 하기
    func register(name: String, email: String, password: String, apiUrl: String, k8SToken: String, isAdmin: Bool, k8sName: String, nsName: String) {
        print("UserVM: register() called")
        AuthAPIService.register(name: name, email: email, password: password, apiUrl: apiUrl, k8SToken: k8SToken, isAdmin: isAdmin, k8sName: k8sName, nsName: nsName)
            .sink(receiveCompletion: { completion in
                    print("UserVM completion: \(completion)")
                switch completion {
                case .failure(let error):
                    print("failed \(error)")
                    self.loginFailed.send()
                case .finished:
                    print("finish")
                }
            },
//                  receiveValue: {})
//            .sink { (completion: Subscribers.Completion<AFError>) in
//                print("UserVM completion: \(completion)")
//                switch completion {
//                case .failure(let error):
//                    print("failed \(error)")
//                    self.loginFailed.send()
//                case .finished:
//                    print("finish")
//                }
             receiveValue: { (receivedUser: UserData) in
                self.loggedInUser = receivedUser
                self.registrationSuccess.send()
            }).store(in: &subscription)
    }
    
    //로그인 하기
    func login(email: String, password: String) {
        print("UserVM: register() called")
        
        AuthAPIService.login(email: email, password: password)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserVM completion: \(completion)")
            } receiveValue: { (receivedUser: UserData) in
                print("login in")
                self.loggedInUser = receivedUser
                self.loginSuccess.send()
                self.isClusterAdmin = UserDefaultManager.shared.getIsAdmin()
            }.store(in: &subscription)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.isLoading.toggle()
            if self.loggedInUser == nil {
                self.loginFailed.send()
                
            }
        }
        
    }
}

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx =
            "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isPassword() -> Bool {
        let passwordRegex =
            "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<]{6,}$"
        let passwordProd = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordProd.evaluate(with: self)
    }
    
    func isUpperCase() -> Bool {
        let uppercaseReqRegex = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", uppercaseReqRegex).evaluate(with: self)
    }
    
    func isLowerCase() -> Bool {
        let lowercaseReqRegex = ".*[a-z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", lowercaseReqRegex).evaluate(with: self)
    }
    
    func containnsCharacter() -> Bool {
        let characterReqRegex = ".*[!@#$%^&*()\\-_=+{}|?>.<]+.*"
        return NSPredicate(format: "SELF MATCHES %@", characterReqRegex).evaluate(with: self)
    }
    
    func containsDigit() -> Bool {
        let digitReqRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", digitReqRegex).evaluate(with: self)
    }
    
    
}

extension Bool {
    func getEnable(registerUser: Bool, emailError: String, passError: String, equalError: String) -> Bool {
        if registerUser {
            if emailError == "" && passError == "" && equalError == "OK" {
                return true
            }
        } else {
            if emailError == "" && passError == "" {
                return true
            }
        }
        
        return false
    }
}

