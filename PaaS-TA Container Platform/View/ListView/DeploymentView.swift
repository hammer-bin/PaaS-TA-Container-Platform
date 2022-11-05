//
//  DeploymentView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/04.
//

import SwiftUI

struct DeploymentView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var deployData : [DeployData] = []
    @State var namespaceData : [NamespaceData] = []
       
    var body: some View {
        
        VStack{
            
            Text("Deployment")
                .font(.largeTitle)
                .fontWeight(.heavy)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        VStack(alignment: .center, spacing: 0) {
                            
                            VStack(alignment: .leading, content: {
                                Text("You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate. You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.")
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
                                k8sVM.deployList()
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
                    
                    if deployData.count > 0 {
                        ForEach(deployData) {sData in
                            //Group
                            ZStack{
                                DeploymentCardView(deployInfo: sData)
                                    .onTapGesture {
                                        withAnimation{
                                            print("sData :: \(sData)")
                                            k8sVM.currentDeploy = sData
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
                    k8sVM.deployList()
                })
                .onReceive(k8sVM.$deploymemts, perform: { self.deployData = $0 })
                .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
//                .onChange(of: k8sVM.showMenu){value in
//                    if value == false {
//                        k8sVM.deployList()
//                    }
//                }
                
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
            .sheet(isPresented: $k8sVM.showDetail) {
                DetailDeployView()
            }
        }
    }
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {
            k8sVM.currentNS = namespaceName
            k8sVM.deployList()
        }) {
            Text(namespaceName)
        }
    }
}

struct DeploymentView_Previews: PreviewProvider {
    static var previews: some View {
        DeploymentView()
    }
}
