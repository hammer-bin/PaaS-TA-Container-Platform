//
//  ResourceQuotaView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import SwiftUI

struct ResourceQuotaView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @EnvironmentObject var userVM : UserVM
    @State var resourceQuotaData : [ResourceQuotaData] = []
    @State var namespaceData : [NamespaceData] = []
       
    var body: some View {
        
        VStack{
            
            Text("ResourceQuota")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 10)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("A resource quota, defined by a ResourceQuota object, provides constraints that limit aggregate resource consumption per namespace. It can limit the quantity of objects that can be created in a namespace by type, as well as the total amount of compute resources that may be consumed by resources in that namespace.")
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
                                    k8sVM.resourceQuotaList()
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
                    
                    if resourceQuotaData.count > 0 {
                        ForEach(resourceQuotaData) {sData in
                            //Group
                            ZStack{
                                ResourceQuotaCardView(resourceQuotaInfo: sData)
                                    .onTapGesture {
                                        withAnimation{
                                            print("sData :: \(sData)")
                                            k8sVM.currentResourceQuota = sData
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
                    print("ResourceQuotaView onAppear() called")
                })
                .onAppear(perform: {
                    k8sVM.resourceQuotaList()
                })
                .onReceive(k8sVM.$resourceQuotas, perform: { self.resourceQuotaData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
                .onChange(of: k8sVM.showMenu){value in
                    if value == false {
                        k8sVM.resourceQuotaList()
                    }
                }
                
            }
            .padding(.top, 5)
            .overlay(
                Image("quota-ori")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .sheet(isPresented: $k8sVM.showDetail){
                DetailResourceQuotaView()
            }
        }
    }
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.resourceQuotaList()
        }) {
            Text(namespaceName)
        }
    }
}

struct ResourceQuotaView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceQuotaView()
    }
}
