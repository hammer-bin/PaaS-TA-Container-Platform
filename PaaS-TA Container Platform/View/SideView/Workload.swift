//
//  Workload.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/30.
//

import SwiftUI

struct Workload: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var current = "Deployment"
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $current){
                
                DeploymentView()
                    .tag("Deployment")
                
                PodView()
                    .tag("Pod")
                
                ReplicaSetListView()
                    .tag("ReplicaSet")
            }
            
            HStack(spacing: 0){
                
                //TabButton...
                LowTabButton(title: "Deployment", image: "deploy-gray", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "Pod", image: "pod-gray", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "ReplicaSet", image: "rs-gray", selected: $current)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal,15)
            .opacity(k8sVM.showDetail ? 0 : 1)
        }
        .onAppear{
            print("Workload onAppear")
            k8sVM.searchResource = .deployment
        }
        .onChange(of: current) { value in
            switch value {
            case "Deployment":
                k8sVM.searchResource = .deployment
            case "Pod":
                k8sVM.searchResource = .pod
            case "ReplicaSet":
                k8sVM.searchResource = .rs
            default:
                k8sVM.searchResource = .deployment
            }
        }
    }
}

struct Workload_Previews: PreviewProvider {
    static var previews: some View {
        Workload()
    }
}
