//
//  ReplicaSetListView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/02.
//

import SwiftUI

struct ReplicaSetListView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var rsData : [RSData] = []
    @State var namespaceData : [NamespaceData] = []
       
    var body: some View {
        
        VStack{
            
            Text("ReplicaSet")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 10)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("A ReplicaSet's purpose is to maintain a stable set of replica Pods running at any given time. As such, it is often used to guarantee the availability of a specified number of identical Pods.")
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
                                k8sVM.rsList()
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
                    
                    if rsData.count > 0 {
                        ForEach(rsData) {sData in
                            //Group
                            ZStack{
                                RSCardView(rsInfo: sData)
                                    .onTapGesture {
                                        withAnimation{
                                            print("sData :: \(sData)")
                                            k8sVM.currentRS = sData
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
                    print("ServiceView onAppear() called")
                })
                .onAppear(perform: {
                    k8sVM.rsList()
                })
                .onReceive(k8sVM.$rss, perform: { self.rsData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
                .onChange(of: k8sVM.showMenu){value in
                    if value == false {
                        k8sVM.rsList()
                    }
                }
                
            }
            .padding(.top, 5)
            .overlay(
                Image("rs-ori")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .sheet(isPresented: $k8sVM.showDetail){
                DetailRSView()
            }
        }
    }
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.rsList()
        }) {
            Text(namespaceName)
        }
    }
}

struct ReplicaSetListView_Previews: PreviewProvider {
    static var previews: some View {
        ReplicaSetListView()
    }
}
