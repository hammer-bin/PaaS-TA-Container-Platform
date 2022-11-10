//
//  UserStorage.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/06.
//

import SwiftUI

struct UserStorage: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var current = "Persistent Volumes Claims"
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $current){
                
                PVCView()
                    .tag("Persistent Volumes Claims")
                
                SCView()
                    .tag("Storage Classes")
            }
            
            HStack(spacing: 0){
                
                LowTabButton(title: "Persistent Volumes Claims", image: "pvc-gray", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "Storage Classes", image: "sc-gray", selected: $current)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal,15)
            .opacity(k8sVM.showDetail ? 0 : 1)
        }
        .onAppear{
            print("Storage onAppear")
            k8sVM.searchResource = .pvc
        }
        .onChange(of: current) { value in
            switch value {
            case "Persistent Volumes Claims":
                k8sVM.searchResource = .pvc
            case "Storage Classes":
                k8sVM.searchResource = .sc
            default:
                k8sVM.searchResource = .pvc
            }
        }
    }
}


struct UserStorage_Previews: PreviewProvider {
    static var previews: some View {
        UserStorage()
    }
}
