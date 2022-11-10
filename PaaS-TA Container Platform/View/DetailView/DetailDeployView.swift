//
//  DetailDeployView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/09.
//

import SwiftUI

struct DetailDeployView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    
    @State var strategy: String = ""
    @State var minReadySeconds: Int = 0
    @State var revisionHistoryLimit: Int = 0
    @State var selector: [String] = []
    @State var maxSurge: String = "0%"
    @State var maxUnavailable: String = "0%"
    @State var updated: Int = 0
    @State var total: Int = 0
    @State var available: Int = 0
    var body: some View {
        
        if let deploy = k8sVM.currentDeploy, k8sVM.showDetail {
            ScrollView(.vertical, showsIndicators: false){

                VStack{
                    // MARK: - Detail Info
                    VStack{
                        
                        VStack{
                            HStack{
                                ZStack{
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundColor(Color("blue3"))
                                    Circle()
                                        .frame(width: 3)
                                        .foregroundColor(Color("blue"))
                                }
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Detail")
                                        //.font(.caption.bold())
                                        .font(.system(size: 15)).bold()
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                    Color("blue3")
                                        .frame(width: 68, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                Item(title: "Name", value: deploy.name, width: 90)
                                Item(title: "Namespace", value: deploy.namespace, width: 90)
                                //Item(title: "Replica", value: "\(deploy.availableReplicas)/\(deploy.replicas)", width: 90)
                                Item(title: "UID", value: uid, width: 90)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
                        }
                        .padding(.horizontal)
                        
                    
                        VStack{
                            HStack{
                                ZStack{
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundColor(Color("blue3"))
                                    Circle()
                                        .frame(width: 3)
                                        .foregroundColor(Color("blue"))
                                }
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Resource")
                                        //.font(.caption.bold())
                                        .font(.system(size: 15)).bold()
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                    Color("blue3")
                                        .frame(width: 68, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){

                                
                                Item(title: "Strategy", value: strategy, width: 140)
                                Item(title: "minReadySeconds", value: String(minReadySeconds), width: 140)
                                Item(title: "revisionHistoryLimit", value: String(revisionHistoryLimit), width: 140)
                                
                                ItemList(title: "Selector", value: selector, width: 140)
                                
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
                        }
                        .padding(.horizontal)
                        
                        // MARK: - UpdateStrategy
                        VStack{
                            HStack{
                                ZStack{
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundColor(Color("blue3"))
                                    Circle()
                                        .frame(width: 3)
                                        .foregroundColor(Color("blue"))
                                }
                                VStack(alignment: .leading, spacing: 0){
                                    Text("UpdateStrategy")
                                        //.font(.caption.bold())
                                        .font(.system(size: 15)).bold()
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                    Color("blue3")
                                        .frame(width: 68, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                Item(title: "maxSurge", value: maxSurge, width: 110)
                                Item(title: "maxUnavailable", value: maxUnavailable, width: 110)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
                        }
                        .padding(.horizontal)
                        
                        // MARK: - PodStatus
                        VStack{
                            HStack{
                                ZStack{
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundColor(Color("blue3"))
                                    Circle()
                                        .frame(width: 3)
                                        .foregroundColor(Color("blue"))
                                }
                                VStack(alignment: .leading, spacing: 0){
                                    Text("PodStatus")
                                        //.font(.caption.bold())
                                        .font(.system(size: 15)).bold()
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                    Color("blue3")
                                        .frame(width: 68, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 10){
                                Item(title: "Updated", value: String(updated), width: 90)
                                Item(title: "Total", value: String(total), width: 90)
                                Item(title: "Available", value: String(available), width: 90)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
                        }
                        .padding(.horizontal)
                        
                    }
                    .padding(.vertical)
                    .padding(.top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    //.transition(.opacity)
                }
                
            }
            .onAppear(perform: {
                k8sVM.deployInfo(namespace: deploy.namespace, resourceName: deploy.name)
            })
            .onReceive(k8sVM.$deployInfoData, perform: { value in
                self.uid = value?.detail.uid ?? ""
                self.strategy = value?.resourceInfo.strategy ?? ""
                self.minReadySeconds = value?.resourceInfo.minReadySeconds ?? 0
                self.revisionHistoryLimit = value?.resourceInfo.revisionHistoryLimit ?? 0
                self.selector = value?.resourceInfo.Selector ?? []
                self.maxSurge = value?.updateStrategy.maxSurge ?? ""
                self.maxUnavailable = value?.updateStrategy.maxUnavailable ?? ""
                self.updated = value?.podStatus.updated ?? 0
                self.total = value?.podStatus.total ?? 0
                self.available = value?.podStatus.available ?? 0
            })
            .onDisappear(perform: {
                print(".onDisappear :: Deployment")
                k8sVM.currentDeploy = nil
            })
            .edgesIgnoringSafeArea(.all)
            
        }
    }
    
    @ViewBuilder
    func Item(title: String, value: String, width: CGFloat) -> some View {
        HStack{
            Text(title)
                .font(.caption.bold())
                .foregroundColor(.gray)
                .frame(width: width, alignment: .trailing)
                .padding(.trailing)
            Text("\(value)")
                .font(.system(size: 15, design: .rounded))
                .frame(alignment: .leading)
                .fontWeight(.medium)
            Spacer()
        }
    }
    
    @ViewBuilder
    func ItemList(title: String, value: [String], width: CGFloat) -> some View {
        HStack{
            Text(title)
                .font(.caption.bold())
                .foregroundColor(.gray)
                .padding(.trailing)
                .frame(width: width, alignment: .trailing)
            VStack(alignment: .leading, spacing: 3){
                ForEach(value, id: \.self){ am in
                    Text(am)
                        .font(.system(size: 15, design: .rounded))
                        .fontWeight(.medium)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .foregroundColor(.white)
                        .background(
                            Rectangle()
                                .fill(Color.gray)
                                .cornerRadius(3)
                        )
                }
            }
            Spacer()
        }
    }
}
