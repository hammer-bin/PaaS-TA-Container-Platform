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
    @State var size = "Medium"
    
    
    var body: some View {
        
        VStack{
            
            Text("Persistent Volumes Claims")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 50)
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
                
//                .onAppear(perform: {
//                    print("PVCView onAppear() called")
//                    k8sVM.searchResource = .pvc
//                })
                .onAppear(perform: { k8sVM.pvcList()})
                .onReceive(k8sVM.$pvcs, perform: { self.pvcData = $0 })
                .onAppear(perform: {
                    print("PVCView onAppear() called")
                    //k8sVM.searchResource = .pvc
                })
                
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

struct PVCView_Previews: PreviewProvider {
    static var previews: some View {
        PVCView()
    }
}
