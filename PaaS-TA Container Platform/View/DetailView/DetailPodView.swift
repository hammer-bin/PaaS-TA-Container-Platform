//
//  DetailPodView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/05.
//

import SwiftUI

struct DetailPodView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    @State var labels: [String] = []
    @State var annotations: [String] = []
    @State var ip: String = ""
    @State var qosClass: String = ""
    @State var controllers: [String] = []
    @State var volumes: [String] = []
    @State var containerName: [String] = []
    @State var containerImage: [String] = []
    var body: some View {
        
        if let podData = k8sVM.currentPod, k8sVM.showDetail {
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
                                        .frame(width: 48, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)

                            VStack(alignment: .leading, spacing: 10){
                                
                                Item(title: "Name", value: podData.name, width: 90)
                                Item(title: "Namespace", value: podData.namespace, width: 90)
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
                                
                                Item(title: "Nodes", value: podData.node, width: 90)
                                Item(title: "Status", value: podData.status, width: 90)
                                Item(title: "IP", value: ip, width: 90)
                                Item(title: "qo_s_class", value: qosClass, width: 90)
                                Item(title: "restart", value: String(podData.restarts), width: 90)
 
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
                                    Text("Container")
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
                                
                                ItemList(title: "name", value: containerName, width: 110)
                                ItemList(title: "image", value: containerImage, width: 110)

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
                k8sVM.podInfo(namespace: podData.namespace, resourceName: podData.name)
            })
            .onReceive(k8sVM.$podInfoData, perform: { value in
                self.uid = value?.detailPod.uid ?? ""
                self.labels = value?.detailPod.labels ?? []
                self.annotations = value?.detailPod.annotations ?? []
                self.ip = value?.resourcePod.ip ?? ""
                self.qosClass = value?.resourcePod.qoSClass ?? ""
                self.controllers = value?.resourcePod.controllers ?? []
                self.volumes = value?.resourcePod.volumes ?? []
                self.containerName = value?.containerPod.name ?? []
                self.containerImage = value?.containerPod.image ?? []
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
                .padding(.trailing)
                .frame(width: width, alignment: .trailing)
            Text("\(value)")
                .font(.system(size: 15, design: .rounded))
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

struct DetailPodView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPodView()
    }
}
