//
//  Storage.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct Storage: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var current = "Persistent Volumes"
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $current){
                
                PVView()
                    .tag("Persistent Volumes")
                
                PVCView()
                    .tag("Persistent Volumes Claims")
                
                Text("Storage Classes")
                    .tag("Storage Classes")
            }
            
            HStack(spacing: 0){
                
                //TabButton...
                LowTabButton(title: "Persistent Volumes", image: "svc-128", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "Persistent Volumes Claims", image: "ing-128", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "Storage Classes", image: "ing-128", selected: $current)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal,15)
            .opacity(k8sVM.showDetail ? 0 : 1)
        }
        .onChange(of: self.current, perform: {
            if current == "Persistent Volumes" {
                k8sVM.searchResource = .pv
            }
            else if current = "Persistent Volumes Claims" {
                k8sVM.searchResource = .pvc
            }
        })
    }
}

struct Storage_Previews: PreviewProvider {
    static var previews: some View {
        Storage()
    }
}
