//
//  DetailResourceQuotaView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/17.
//

import SwiftUI

struct DetailResourceQuotaView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var scope: String = ""
    @State var status: [Status] = []
    var body: some View {
        
        if let rq = k8sVM.currentResourceQuota, k8sVM.showDetail {
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
                                Item(title: "Name", value: rq.name, width: 90)
                                Item(title: "Namespace", value: rq.namespace, width: 90)
                                Item(title: "Scope", value: scope, width: 90)
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
                            
                            VStack{
                                ForEach(status, id: \.self){ data in
                                    VStack(alignment: .leading, spacing: 10){
                                        
                                        HStack{
                                            Text("ResourceName")
                                                .font(.caption.bold())
                                                .foregroundColor(.gray)
                                                .padding(.trailing)
                                                .frame(width: 140, alignment: .trailing)
                                            Text(data.resourceName ?? "")
                                                .font(.system(size: 15, design: .rounded))
                                                .fontWeight(.medium)
                                            Spacer()
                                        }
                                        
                                        HStack{
                                            Text("Hard")
                                                .font(.caption.bold())
                                                .foregroundColor(.gray)
                                                .padding(.trailing)
                                                .frame(width: 140, alignment: .trailing)
                                            Text(data.hard ?? "")
                                                .font(.system(size: 15, design: .rounded))
                                                .fontWeight(.medium)
                                        }
                                        
                                        HStack{
                                            Text("used")
                                                .font(.caption.bold())
                                                .foregroundColor(.gray)
                                                .padding(.trailing)
                                                .frame(width: 140, alignment: .trailing)
                                            Text(data.used ?? "")
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
                            }
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
                k8sVM.resourceQuotaInfo(namespace: rq.namespace, resourceName: rq.name)
            })
            .onReceive(k8sVM.$resourceQuotaInfoData, perform: { value in
                self.scope = value?.detailRQ.scopes ?? ""
                self.status = value?.detailRQ.status ?? []
            })
            .onDisappear(perform: {
                print(".onDisappear :: ResourceQuota")
                k8sVM.currentResourceQuota = nil
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
