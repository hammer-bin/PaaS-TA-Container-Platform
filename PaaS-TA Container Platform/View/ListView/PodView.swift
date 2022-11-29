//
//  PodView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import SwiftUI

struct PodView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @EnvironmentObject var userVM : UserVM
    @State var podData : [PodData] = []
    @State var namespaceData : [NamespaceData] = []
       
    var body: some View {
        
        VStack{
            
            Text("Pod")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 10)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.")
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
                                    k8sVM.podList()
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
                    
                    if podData.count > 0 {
                        ForEach(podData) {sData in
                            //Group
                            ZStack{
                                PodCardView(podInfo: sData)
                                    .onTapGesture {
                                        withAnimation{
                                            print("sData :: \(sData)")
                                            k8sVM.currentPod = sData
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
                    k8sVM.podList()
                })
                .onReceive(k8sVM.$pods, perform: { self.podData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
                .onChange(of: k8sVM.showMenu){value in
                    if value == false {
                        k8sVM.podList()
                    }
                }
                
            }
            .padding(.top, 5)
            .overlay(
                Image("pod-ori")
                    //.renderingMode(.template)
                    
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 250, height: 250)
                    .opacity(0.1)
            )
            .sheet(isPresented: $k8sVM.showDetail){
                DetailPodView()
            }
        }
    }
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.podList()
        }) {
            Text(namespaceName)
        }
    }
}

struct PodView_Previews: PreviewProvider {
    static var previews: some View {
        PodView()
    }
}
