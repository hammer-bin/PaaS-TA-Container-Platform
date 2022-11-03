//
//  DetailServiceView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/03.
//

import SwiftUI

struct DetailServiceView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    @State var namespace: String = ""
    @State var labels: [String] = []
    @State var annotations: [String] = []
    @State var createdTime: String = ""
    @State var type: String = ""
    @State var clusterIp: String = ""
    @State var sessionAffinity: String = ""
    @State var selector: [String] = []
    
    var body: some View {
        
        if let data = k8sVM.currentService, k8sVM.showDetail {
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
                                        .frame(width: 43, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                HStack{
                                    Text("Name")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(data.name)")
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Namespace")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text("\(data.namespace)")
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                }
                                
                                
                                HStack{
                                    Text("UID")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text(uid)
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                }
                                
                                HStack{
                                    Text("Lables")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    VStack(alignment: .leading, spacing: 3){
                                        ForEach(labels, id: \.self){ am in
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
                                    
                                }
                                
                                HStack{
                                    Text("Anotations")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    VStack(alignment: .leading, spacing: 3){
                                        ForEach(annotations, id: \.self){ am in
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
                                    
                                }
                                
                                HStack{
                                    Text("createTime")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text(createdTime)
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                }
                                
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
                        }
                        .padding(.bottom)
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
                                
                                HStack{
                                    Text("type")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(type)")
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("clusterIp")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(clusterIp)")
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                }
                                
                                HStack{
                                    Text("sessionAffinity")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(sessionAffinity)")
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                }
                                
                                HStack{
                                    Text("selector")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    ForEach(selector, id: \.self){ am in
                                        Text(am)
                                            .font(.system(size: 15, design: .rounded))
                                            .fontWeight(.medium)
                                        //.clipShape(Rectangle())
                                    }
                                }
                                
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
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
                    }
                }
                
            }
            .onAppear(perform: {
                k8sVM.serviceInfo(resourceName: data.name)
            })
            .onReceive(k8sVM.$serviceInfoData, perform: { value in
                self.uid = value?.detailService.uid ?? ""
                self.namespace = value?.detailService.namespace ?? ""
                self.labels = value?.detailService.labels ?? []
                self.annotations = value?.detailService.annotations ?? []
                self.type = value?.resourceService.type ?? ""
                self.clusterIp = value?.resourceService.clusterIP ?? ""
                self.sessionAffinity = value?.resourceService.sessionAffinity ?? ""
                self.selector = value?.resourceService.selector ?? []
                self.createdTime = value?.detailService.createdTime ?? ""
            })
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}
