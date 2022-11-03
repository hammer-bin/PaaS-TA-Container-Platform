//
//  Service.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct Service: View {
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
                LowTabButton(title: "Service", image: "svc-128", selected: $current)
                
                Spacer(minLength: 0)
                
                LowTabButton(title: "Ingress", image: "ing-128", selected: $current)
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal,70)
        }
    }
}

struct Service_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
