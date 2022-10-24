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
    @State var matchLabels: String = ""
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
                                Text("Detail")
                                    //.font(.caption.bold())
                                    .font(.system(size: 15)).bold()
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                                Spacer()
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                HStack{
                                    Text("Name")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(deploy.name)")
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Namespace")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(deploy.namespace)")
                                }
                                
                                HStack{
                                    Text("Replica")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(deploy.availableReplicas)/\(deploy.replicas)")
                                }
                                
                                HStack{
                                    Text("UID")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text(uid)
                                }
                                
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(.linearGradient(colors: [Color.white, Color("blue3")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                        }
                        .padding(.horizontal)
                        
                    
                        VStack{
                            HStack{
                                Text("Resource")
                                    .font(.system(size: 15)).bold()
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                                Spacer()
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                HStack{
                                    Text("Strategy")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(strategy)")
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("minReadySecounds")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(minReadySeconds)")
                                }
                                
                                HStack{
                                    Text("revisionHistoryLimit")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(revisionHistoryLimit)")
                                }
                                
                                HStack{
                                    Text("matchLabels")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text(matchLabels)
                                }
                                
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(.linearGradient(colors: [Color.white, Color("blue3")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                        }
                        .padding(.horizontal)
                        
                        // MARK: - UpdateStrategy
                        VStack{
                            HStack{
                                Text("UpdateStrategy")
                                    .font(.system(size: 15)).bold()
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                                Spacer()
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                HStack{
                                    Text("maxSurge")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 110, alignment: .trailing)
                                    Text("\(maxSurge)")
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("maxUnavailable")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 110, alignment: .trailing)
                                    Text("\(maxUnavailable)")
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(.linearGradient(colors: [Color.white, Color("blue3")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                        }
                        .padding(.horizontal)
                        
                        // MARK: - PodStatus
                        VStack{
                            HStack{
                                Text("PodStatus")
                                    .font(.system(size: 15)).bold()
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                                Spacer()
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                HStack{
                                    Text("updated")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(updated)")
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("total")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(total)")
                                }
                                
                                HStack{
                                    Text("available")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(available)")
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(.linearGradient(colors: [Color.white, Color("blue3")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                        }
                        .padding(.horizontal)
                        
                    }
                    .padding(.vertical)
                    .padding(.top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    //.transition(.opacity)
                    
                    // MARK: - Back Button
                    HStack{
                        
                        Button(action: {
                            withAnimation{
                                k8sVM.showDetail = false
                            }
                        }) {
                            
                            HStack{
                                
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                
                                Text("Back")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            .background(
                             
                                Color("blue2")
                                
                            )
                            .cornerRadius(10)
                        }
                        .padding(.leading, 35)
                        
                        Button(action: {
                            
                        }) {
                            HStack{
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                
                                Text("Delete")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            .background(
                                LinearGradient(gradient: .init(colors: [Color("blue2"), Color("blue2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(10)
                        }
                        .padding(.leading, 35)
                    }
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
                self.matchLabels = value?.resourceInfo.selector.matchLabels.app ?? ""
                self.maxSurge = value?.updateStrategy.maxSurge ?? ""
                self.maxUnavailable = value?.updateStrategy.maxUnavailable ?? ""
                self.updated = value?.podStatus.updated ?? 0
                self.total = value?.podStatus.total ?? 0
                self.available = value?.podStatus.available ?? 0
            })
            .edgesIgnoringSafeArea(.all)
            
        }
            
        
        
    }
}
