//
//  Service.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct Service: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var current = "Service"
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $current){
                
                ServiceView()
                    .tag("Service")
                
                IngressView()
                    .tag("Ingress")
            }
            
            HStack(spacing: 0){
                
                //TabButton...
                LowTabButton(title: "Service", image: "svc-gray", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "Ingress", image: "ing-gray", selected: $current)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal,70)
        }
        .onAppear{
            print("Service onAppear")
            k8sVM.searchResource = .svc
        }
        .onChange(of: current) { value in
            switch value {
            case "Service":
                k8sVM.searchResource = .svc
            case "Ingress":
                k8sVM.searchResource = .ingress
            default:
                k8sVM.searchResource = .svc
            }
        }
    }
}

struct Service_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
