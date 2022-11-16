//
//  Config.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import SwiftUI

struct Config: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var current = "Configmap"
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $current){
                
                ConfigmapView()
                    .tag("Configmap")
                
                SecretView()
                    .tag("Secret")
            }
            
            HStack(spacing: 0){
                
                //TabButton...
                LowTabButton(title: "Configmap", image: "cm-gray", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "Secret", image: "secret-gray", selected: $current)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal,70)
        }
        .onAppear{
            print("Config onAppear")
            k8sVM.searchResource = .configmap
        }
        .onChange(of: current) { value in
            switch value {
            case "Configmap":
                k8sVM.searchResource = .configmap
            case "Secret":
                k8sVM.searchResource = .secret
            default:
                k8sVM.searchResource = .secret
            }
        }
    }
}

struct Config_Previews: PreviewProvider {
    static var previews: some View {
        Config()
    }
}
