//
//  ConfigmapView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import SwiftUI

struct ConfigmapView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @EnvironmentObject var userVM : UserVM
    @State var configmapData : [ConfigmapData] = []
    @State var namespaceData : [NamespaceData] = []
       
    var body: some View {
        
        VStack{
            
            Text("Configmap")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 10)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.")
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
                                    k8sVM.configmapList()
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
                    
                    if configmapData.count > 0 {
                        ForEach(configmapData) {sData in
                            //Group
                            ZStack{
                                ConfigmapCardView(configmapInfo: sData)
                                    .onTapGesture {
                                        withAnimation{
                                            print("sData :: \(sData)")
                                            k8sVM.currentConfigmap = sData
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
                    print("ConfigmapView onAppear() called")
                })
                .onAppear(perform: {
                    k8sVM.configmapList()
                })
                .onReceive(k8sVM.$configmaps, perform: { self.configmapData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
                .onChange(of: k8sVM.showMenu){value in
                    if value == false {
                        k8sVM.configmapList()
                    }
                }
                
            }
            .padding(.top, 5)
            .overlay(
                Image("cm-ori")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .sheet(isPresented: $k8sVM.showDetail){
                DetailConfigmapView()
            }
        }
    }
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.configmapList()
        }) {
            Text(namespaceName)
        }
    }
}

struct ConfigmapView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigmapView()
    }
}
