//
//  ServiceView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/09.
//

import SwiftUI

struct ServiceView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var serviceData : [ServiceData] = []
    @State var namespaceData : [NamespaceData] = []
    @State var size = "Medium"
    
    
    var body: some View {
        
        VStack{
            
            Text("Service")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("An abstract way to expose an application running on a set of Pods as a network service.")
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
                            .background(Color.black)
                            .clipShape(Capsule())
                        }
                    }
                    .padding()
                    
                    ForEach(serviceData) {sData in
                        //Group
                        ZStack{
                            
     
                            
                            ServiceCardView(serviceInfo: sData)
                                .onTapGesture {
                                    withAnimation{
                                        k8sVM.currentService = sData
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
                })
                .onAppear(perform: { k8sVM.serviceList()})
                .onReceive(k8sVM.$services, perform: { self.serviceData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
                
            }
            .padding(.top, 5)
            .overlay(
                Image("svc-256")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .overlay(
                DetailDeployView()
            )
            
        }
    }
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.serviceList()
        }) {
            Text(namespaceName)
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
