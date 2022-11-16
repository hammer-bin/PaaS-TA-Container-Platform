//
//  DetailConfigmapView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/16.
//

import SwiftUI

struct DetailConfigmapView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    
    @State var labels: [String] = []
    @State var annotations: [String] = []
    @State var data: [String] = []
    var body: some View {
        
        if let configmap = k8sVM.currentConfigmap, k8sVM.showDetail {
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
                                Item(title: "Name", value: configmap.name, width: 90)
                                Item(title: "Namespace", value: configmap.namespace, width: 90)
                                Item(title: "UID", value: uid, width: 90)
                                ItemList(title: "Labels", value: labels, width: 90)
                                ItemList(title: "Annotations", value: annotations, width: 90)
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
                                ItemList(title: "Data", value: data, width: 90)
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
                k8sVM.configmapInfo(namespace: configmap.namespace, resourceName: configmap.name)
            })
            .onReceive(k8sVM.$configmapInfoData, perform: { value in
                self.uid = value?.metadata.uid ?? ""
                self.labels = value?.metadata.labels ?? []
                self.annotations = value?.metadata.annotations ?? []
                self.data = value?.data ?? []
            })
            .onDisappear(perform: {
                print(".onDisappear :: Configmap")
                k8sVM.currentConfigmap = nil
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
