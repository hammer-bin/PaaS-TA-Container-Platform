//
//  PaaS_TA_Container_PlatformApp.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import SwiftUI
import Combine
import Alamofire

@main
struct PaaS_TA_Container_PlatformApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserVM())
                .environmentObject(K8sVM())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var subscription = Set<AnyCancellable>()
    @Published var deviceToken: String = ""
    
    //앱이 켜졌을때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        registerForRemoteNotifications()
        
        return true
    }
    
    private func registerForRemoteNotifications() {
        
        // 1. 푸시 center(유저에게 권한요청)
        let center = UNUserNotificationCenter.current()
        center.delegate = self // push처리에 대한 delegate - UNUserNotificationCenterDelegate
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (granted, error) in
            
            guard granted else {
                return
            }
            
            DispatchQueue.main.async {
                // 2. APNs에 디바이스 토큰 등록
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    // 푸시 토큰 받기 성공
    internal func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.sendDeviceTokenToServer(data: deviceToken)
    }
    
    private func sendDeviceTokenToServer(data: Data) {
        var token: String = ""
        //var resultToken: String = ""
        for i in 0..<data.count {
            token += String(format: "%02.2hhx", data[i] as CVarArg)
        }
        print("APNs token : \(token)")
        print("token\(data)")
        
        UserDefaultManager.shared.setDeviceToken(deviceToken: token)
        
        updateDeviceToken(token: token)
        //print("resultToken:: \(resultToken)")
        
        //let deviceTokenString = data.map{String(format: "%02x", $0)}.joined()
        //print(deviceTokenString)
    }
    
    func updateDeviceToken(token: String) {
        updateDeviceTokenData(token: token)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserVM completion: \(completion)")
            } receiveValue: { (receivedData : ApnsTokenData) in
                print("update to device token")
                self.deviceToken = receivedData.deviceToken
            }.store(in: &subscription)
    }
    
    //APNs 디바이스 토큰 저장
    private func updateDeviceTokenData(token: String)-> AnyPublisher<ApnsTokenData, AFError> {
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
    
    // 푸시 토큰 받기 실패
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
}
    
extension AppDelegate: UNUserNotificationCenterDelegate {

    // 앱이 foreground상태 일 때, 알림이 온 경우 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        // 푸시가 오면 alert, badge, sound표시를 하라는 의미
        completionHandler([.banner, .badge, .sound])
    }

    // push를 탭한 경우 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        // deep link처리 시 아래 url값 가지고 처리
        let url = response.notification.request.content.userInfo
        print("url = \(url)")
        // if url.containts("receipt")...
    }
    
}
