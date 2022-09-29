//
//  Workload.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/30.
//

import SwiftUI

struct Workload: View {
    var body: some View {
        NavigationView{
            Text("Deployment, Pod, ReplicaSet")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Workload")
        }
    }
}

struct Workload_Previews: PreviewProvider {
    static var previews: some View {
        Workload()
    }
}
