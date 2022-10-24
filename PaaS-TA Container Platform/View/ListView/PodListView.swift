//
//  PodListView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/02.
//

import SwiftUI

struct PodListView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var podData : [PodData] = []
    
    var body: some View {
        ZStack{
            //Color("Purple")
            Color("bg")
                .clipShape(WorkLoadCustomCorner(corner: .topRight, size: 65))
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 20){
                    HStack{
                        Text("Pod")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                        
                        Text("Count :: \(podData.count)")
                        
                        Button(action: {}, label: {
                            
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 22))
                                .foregroundColor(.primary)
                        })
                    }
                    .padding()
                    
                    ForEach(podData) {dData in
                        //Group
                        HStack{
                            PodItemView(info: dData)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            })
            //.clipShape(CustomCorner(corner: .topRight, size: 65))
        }
        .onAppear(perform: {
            print("WorkloadView onAppear() called")
        })
        .onAppear(perform: { k8sVM.podList()})
        .onReceive(k8sVM.$pods, perform: { self.podData = $0 })
    }
}

struct PodListView_Previews: PreviewProvider {
    static var previews: some View {
        PodListView()
    }
}

struct PodItemView : View {
    var info : PodData
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(alignment: .leading, spacing: 8){
                Text(info.name)
                    .fontWeight(.bold)
                
                Text(info.namespace)
                    .font(.caption)
                    .lineLimit(1)
                
            }
            Spacer()
            
            Text(info.createdTime)
                .font(.system(size: 15))
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}
