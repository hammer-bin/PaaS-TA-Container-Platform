//
//  DetailPVCView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/10.
//

import SwiftUI

struct DetailPVCView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    
    @State var status: String = ""
    @State var storageClass: String = ""
    @State var storage: String = ""
    @State var accessMode: [String] = []
    @State var labels: [String] = []
    @State var annotations: [String] = []
    @State var createdTime: String = ""
    var body: some View {
        
        if let data = k8sVM.currentPVC, k8sVM.showDetail {
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
                                Item(title: "Name", value: data.name, width: 90)
                                Item(title: "Namespace", value: data.namespace, width: 90)
                                Item(title: "UID", value: uid, width: 90)
                                ItemList(title: "Labels", value: labels, width: 90)
                                ItemList(title: "Annotations", value: annotations, width: 90)
                                Item(title: "CreateTime", value: createdTime, width: 90)
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
                                
                                Item(title: "Status", value: status, width: 100)
                                Item(title: "StorageClass", value: storageClass, width: 100)
                                Item(title: "Storate", value: storage, width: 100)
                                ItemList(title: "AccessMode", value: accessMode, width: 100)
                                
                                
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
                }
                
            }
            .onAppear(perform: {
                k8sVM.pvcInfo(namespace: data.namespace, resourceName: data.name)
            })
            .onReceive(k8sVM.$pvcInfoData, perform: { value in
                self.uid = value?.detailPVC.uid ?? ""
                self.status = value?.resourcePVC.status ?? ""
                self.storageClass = value?.resourcePVC.storageClass ?? ""
                self.storage = value?.resourcePVC.capacity.storage ?? ""
                self.accessMode = value?.resourcePVC.accessMode ?? []
                self.labels = value?.detailPVC.labels ?? ["-"]
                self.annotations = value?.detailPVC.annotations ?? ["-"]
                self.createdTime = value?.detailPVC.createdTime ?? "-"
            })
            .onDisappear(perform: {
                print(".onDisappear :: PVC")
                k8sVM.currentPVC = nil
            })
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            
        }
    }
    
    @ViewBuilder
    func Item(title: String, value: String, width: CGFloat) -> some View {
        HStack{
            Text(title)
                .font(.caption.bold())
                .foregroundColor(.gray)
                .padding(.trailing)
                .frame(width: width, alignment: .trailing)
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
