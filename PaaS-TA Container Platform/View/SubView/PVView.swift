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
    @State var size = "Medium"
    
    
    var body: some View {
        
        VStack{
            
            Text("Persistent Volumes")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
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
                        
                        // Menu Button...
                        
                        Menu(content: {
                            
                            Button(action: {size = "Small"}) {
                                
                                Text("Small")
                            }
                            Button(action: {size = "Midium"}) {
                                
                                Text("Midium")
                            }
                            Button(action: {size = "Large"}) {
                                
                                Text("Large")
                            }
                            
                        }) {
                            
                            Label(title: {
                                Text(size)
                                    .foregroundColor(.white)
                            }) {
                                Image(systemName: "slider.vertical.3")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black)
                            .clipShape(Capsule())
                        }
                    }
                    .padding()
                    
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
                
                .onAppear(perform: {
                    print("ServiceView onAppear() called")
                    k8sVM.searchResource = "pv"
                })
                .onAppear(perform: { k8sVM.pvList()})
                .onReceive(k8sVM.$pvs, perform: { self.pvData = $0 })
                
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
                DetailPVCView()
            )
            
        }
    }
}

struct PVView_Previews: PreviewProvider {
    static var previews: some View {
        PVView()
    }
}
