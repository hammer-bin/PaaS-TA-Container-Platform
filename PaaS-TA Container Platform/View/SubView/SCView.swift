//
//  SCView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/02.
//

import SwiftUI

struct SCView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var scData : [SCData] = []
    
    var body: some View {
        
        VStack{
            
            Text("StorageClass")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 50)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("A StorageClass provides a way for administrators to describe the 'classes' of storage they offer. Different classes might map to quality-of-service levels, or to backup policies, or to arbitrary policies determined by the cluster administrators. Kubernetes itself is unopinionated about what classes represent. This concept is sometimes called 'profiles' in other storage systems.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .fontWeight(.bold)
                            })
                            
                        }

                    }
                    .padding()
                    
                    ForEach(scData) {data in
                        ZStack{
                            SCCardView(scInfo: data)
                                .onTapGesture {
                                    withAnimation{
                                        k8sVM.currentSC = data
                                        k8sVM.showDetail = true
                                    }
                                }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    }
                    
                }
                .onAppear(perform: { k8sVM.scList()})
                .onReceive(k8sVM.$scs, perform: { self.scData = $0 })
            }
            .padding(.top, 5)
            .overlay(
                Image("pvc-256")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .overlay(
                DetailSCView()
            )
            
        }
    }
}

struct SCView_Previews: PreviewProvider {
    static var previews: some View {
        SCView()
    }
}
