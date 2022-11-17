//
//  Quota.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import SwiftUI

struct Quota: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var current = "ResourceQuota"
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $current){
                
                ResourceQuotaView()
                    .tag("ResourceQuota")
                
                LimitRangeView()
                    .tag("LimitRange")
            }
            
            HStack(spacing: 0){
                
                //TabButton...
                LowTabButton(title: "ResourceQuota", image: "quota-gray", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "LimitRange", image: "limits-gray", selected: $current)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal,60)
        }
        .onAppear{
            print("Quota onAppear")
            k8sVM.searchResource = .resourceQuota
        }
        .onChange(of: current) { value in
            switch value {
            case "ResourceQuota":
                k8sVM.searchResource = .resourceQuota
            case "LimitRange":
                k8sVM.searchResource = .limitRange
            default:
                k8sVM.searchResource = .resourceQuota
            }
        }
    }
}

struct Quota_Previews: PreviewProvider {
    static var previews: some View {
        Quota()
    }
}
