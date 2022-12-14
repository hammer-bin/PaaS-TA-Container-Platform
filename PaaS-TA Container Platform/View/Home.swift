//
//  Home.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var k8sVM : K8sVM
    @EnvironmentObject var userVM : UserVM
    @Binding var selectedTab: String
    
//    @State var name: String = ""
//    @State var namespace: String = ""
//    @State var uid: String = ""
//    @State var status: String = ""
//    @State var pvcdatas : [PVCData] = []
    
    // Hiding Tab bar...
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        // Tab View With Tabs...
        TabView(selection: $selectedTab){
            if !UserDefaultManager.shared.getIsAdmin() {
                UserDashboard()
                    .tag("Dashbaord")
                
                Workload()
                    .tag("Workload")
                
                Service()
                    .tag("Service")
                
                UserStorage()
                    .tag("Storage")
                
                Config()
                    .tag("Config")
                
                //Quota()
                    //.tag("Quota")
            }
            else {
                HomePage()
                    .tag("Dashboard")
                
                Workload()
                    .tag("Workload")
                
                Service()
                    .tag("Service")
                
                Storage()
                    .tag("Storage")
                
                Config()
                    .tag("Config")
                
                //Quota()
                    //.tag("Quota")
            }
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
