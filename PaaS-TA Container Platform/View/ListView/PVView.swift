//
//  PVView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct PVView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var pvData : [PVData] = []
    
    var body: some View {
        
        VStack{
            
            Text("Persistent Volumes")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.top, 50)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("A PersistentVolume (PV) is a piece of storage in the cluster that has been provisioned by an administrator or dynamically provisioned using Storage Classes. It is a resource in the cluster just like a node is a cluster resource. PVs are volume plugins like Volumes, but have a lifecycle independent of any individual Pod that uses the PV. This API object captures the details of the implementation of the storage, be that NFS, iSCSI, or a cloud-provider-specific storage system.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .fontWeight(.bold)
                            })
                            
                        }
                        
                        Spacer(minLength: 15)
                        
                        
                    }
                    .padding()
                    
                    if pvData.count > 0 {
                        ForEach(pvData) {data in
                            //Group
                            ZStack{
                                
         
                                
                                PVCardView(pvInfo: data)
                                    .onTapGesture {
                                        withAnimation{
                                            k8sVM.currentPV = data
                                            k8sVM.showDetail = true
                                        }
                                    }
                                    
                                
                                
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    else {
                        VStack(alignment: .center){
                            Text("No Data.")
                                .font(.system(size: 22, design: .rounded))
                                .fontWeight(.bold)
                            Image("NoData_gray")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120)
                        }
                        
                    }
                    
                }
                
                .onAppear(perform: {
                    print("PVView onAppear() called")
                    //k8sVM.searchResource = .pv
                })
                .onAppear(perform: { k8sVM.pvList()})
                .onReceive(k8sVM.$pvs, perform: { self.pvData = $0 })
                
            }
            .padding(.top, 5)
            .overlay(
                Image("pv-ori")
                    //.renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .sheet(isPresented: $k8sVM.showDetail){
                DetailPVView()
            }
            
        }
    }
}

struct PVView_Previews: PreviewProvider {
    static var previews: some View {
        PVView()
    }
}
