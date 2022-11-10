//
//  PVCView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct PVCView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var pvcData : [PVCData] = []
    @State var namespaceData : [NamespaceData] = []
    
    var body: some View {
        
        VStack{
            
            Text("Persistent Volumes\nClaims")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.top, 10)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("A PersistentVolumeClaim (PVC) is a request for storage by a user. It is similar to a Pod. Pods consume node resources and PVCs consume PV resources.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .fontWeight(.bold)
                            })
                            
                        }
                        
                        Spacer(minLength: 15)
                        
                        // Menu Button...
                        
                        Menu(content: {
                            
                            Button(action: {
                                k8sVM.currentNS = "All"
                                k8sVM.serviceList()
                            }) {
                                Text("All namespace")
                            }
                            ForEach(namespaceData) { datum in
                                NamespaceButton(namespaceName: datum.name)
                            }
                
                        }) {
                            
                            Label(title: {
                                Text(k8sVM.currentNS)
                                    .foregroundColor(.white)
                            }) {
                                Image(systemName: "rectangle.split.3x1")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .frame(maxWidth: 240, alignment: .leading)
                            .fontWeight(.semibold)
                            .background(Color("base"))
                            .clipShape(Capsule())
                        }
                    }
                    .padding()
                    
                    if pvcData.count > 0 {
                        ForEach(pvcData) {data in
                            //Group
                            ZStack{
                                PVCCardView(pvcInfo: data)
                                    .onTapGesture {
                                        withAnimation{
                                            k8sVM.currentPVC = data
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
                
//                .onAppear(perform: {
//                    print("PVCView onAppear() called")
//                    k8sVM.searchResource = .pvc
//                })
                .onAppear(perform: { k8sVM.pvcList()})
                .onReceive(k8sVM.$pvcs, perform: { self.pvcData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
                .onAppear(perform: {
                    print("PVCView onAppear() called")
                    //k8sVM.searchResource = .pvc
                })
                
            }
            .padding(.top, 5)
            .overlay(
                Image("pvc-ori")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .sheet(isPresented: $k8sVM.showDetail){
                DetailPVCView()
            }
            
        }
    }
    
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.pvcList()
        }) {
            Text(namespaceName)
        }
    }
}

struct PVCView_Previews: PreviewProvider {
    static var previews: some View {
        PVCView()
    }
}
