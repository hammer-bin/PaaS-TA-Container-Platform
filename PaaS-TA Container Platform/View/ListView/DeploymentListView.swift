//
//  DeploymentListView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/02.
//

import SwiftUI

struct DeploymentListView: View {
    
    @EnvironmentObject var k8sVM : K8sVM
    @State var deployData : [DeployData] = []
    
    var body: some View {
        VStack{
            ZStack{
                //Color("Purple")
                Color("bg")
                    .clipShape(WorkLoadCustomCorner(corner: .topRight, size: 65))
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 20){
                        HStack{
                            Text("Deployment")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer(minLength: 0)
                            
                            Button(action: {}, label: {
                                
                                Image(systemName: "slider.horizontal.3")
                                    .font(.system(size: 22))
                                    .foregroundColor(.primary)
                            })
                        }
                        .padding()
                        
                        ForEach(deployData) {dData in
                            //Group
                            HStack{
                                ListView(deployInfo: dData)
                                    .onTapGesture {
                                        withAnimation{
                                            k8sVM.currentDeploy = dData
                                            k8sVM.showDetail = true
                                        }
                                    }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                })
                //.clipShape(CustomCorner(corner: .topRight, size: 65))
            }
            .onAppear(perform: {
                print("WorkloadView onAppear() called")
            })
            .onAppear(perform: { k8sVM.deployList()})
            .onReceive(k8sVM.$deploymemts, perform: { self.deployData = $0 })
            .opacity(k8sVM.showDetail ? 0 : 1)
        }
        .overlay(
            DetailDeployView()
        )
        
    }
}

struct DeploymentListView_Previews: PreviewProvider {
    static var previews: some View {
        DeploymentListView()
    }
}
