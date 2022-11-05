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
    
    @State var name: String = ""
    @State var namespace: String = ""
    @State var uid: String = ""
    @State var status: String = ""
    @State var pvcdatas : [PVCData] = []
    
    // Hiding Tab bar...
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        // Tab View With Tabs...
        TabView(selection: $selectedTab){
            
            if !userVM.isClusterAdmin {
                UserDashboard()
                    .tag("Home")
                
                Workload()
                    .tag("Workload")
                
                Service()
                    .tag("Service")
                
                UserStorage()
                    .tag("Storage")
                
                Notifications()
                    .tag("Notifications")
            }
            else {
                HomePage()
                    .tag("Home")
                
                Workload()
                    .tag("Workload")
                
                Service()
                    .tag("Service")
                
                Storage()
                    .tag("Storage")
                
                Notifications()
                    .tag("Notifications")
            }
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Notifications: View {
    var body: some View{
        
        NavigationView{
            Text("Notifications")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Notifications")
        }
    }
}
struct Help: View {
    var body: some View{
        
        NavigationView{
            Text("Help")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Help")
        }
    }
}
