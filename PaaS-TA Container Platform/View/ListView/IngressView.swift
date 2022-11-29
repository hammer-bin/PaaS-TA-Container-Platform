//
//  IngressView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/04.
//

import SwiftUI

struct IngressView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @EnvironmentObject var userVM : UserVM
    @State var ingressData : [IngressData] = []
    @State var namespaceData : [NamespaceData] = []
       
    var body: some View {
        
        VStack{
            
            Text("Ingress")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 10)
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
                        if userVM.isClusterAdmin {
                            Menu(content: {
                                
                                Button(action: {
                                    k8sVM.currentNS = "All"
                                    k8sVM.ingressList()
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
                        } else {
                            Menu(content: {
                                
                                Button(action: {}) {
                                    Text(userVM.userNamespace)
                                }
                                
                            }) {
                                
                                Label(title: {
                                    Text(userVM.userNamespace)
                                        .lineLimit(1)
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
                    }
                    .padding()
                    
                    if ingressData.count > 0 {
                        ForEach(ingressData) {sData in
                            //Group
                            ZStack{
                                IngressCardView(ingressInfo: sData)
                                    .onTapGesture {
                                        withAnimation{
                                            print("sData :: \(sData)")
                                            k8sVM.currentIngress = sData
                                            k8sVM.showDetail = true
                                            print("showDetail :: \(k8sVM.showDetail)")
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
                    print("IngressView onAppear() called")
                })
                .onAppear(perform: {
                    k8sVM.ingressList()
                })
                .onReceive(k8sVM.$ingresses, perform: { self.ingressData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
                .onChange(of: k8sVM.showMenu){value in
                    if value == false {
                        k8sVM.ingressList()
                    }
                }
                
            }
            .padding(.top, 5)
            .overlay(
                Image("ing-ori")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .sheet(isPresented: $k8sVM.showDetail){
                DetailIngressView()
            }
            
        }
    }
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.ingressList()
        }) {
            Text(namespaceName)
        }
    }
}

struct IngressView_Previews: PreviewProvider {
    static var previews: some View {
        IngressView()
    }
}
