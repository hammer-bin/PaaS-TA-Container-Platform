//
//  DetailPVView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/28.
//

import SwiftUI

struct DetailPVView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    
    @State var status: String = ""
    @State var storageClass: String = ""
    @State var claim: String = ""
    @State var accessMode: [String] = []
    @State var type: String = ""
    @State var server: String = ""
    @State var path: String = ""
    @State var resourceName: String = ""
    @State var capacity: String = ""
    var body: some View {
        
        if let data = k8sVM.currentPV, k8sVM.showDetail {
            ScrollView(.vertical, showsIndicators: false){
                
                if k8sVM.showDetailSearch {
                    VStack{
                        Text("Search Detail")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            
                    }
                }

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
                                Item(title: "Name", value: data.name, width: 80)
                                Item(title: "UID", value: uid, width: 80)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color("blue").opacity(0.1))
                            .cornerRadius(20)
                            //.shadow(color: Color.black.opacity(0.18), radius: 5, x:5, y: 5)
                            //.shadow(color: Color.black.opacity(0.18), radius: 5, x: -5, y: -5)
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
                                Item(title: "Claim", value: claim, width: 100)
                                ItemList(title: "AccessMode", value: accessMode, width: 100)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color("blue").opacity(0.1))
                            .cornerRadius(20)
                            //.shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            //.shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
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
                                    Text("Source")
                                        //.font(.caption.bold())
                                        .font(.system(size: 15)).bold()
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                    Color("blue3")
                                        .frame(width: 55, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                Item(title: "Type", value: type, width: 100)
                                Item(title: "Server", value: server, width: 100)
                                Item(title: "path", value: path, width: 100)
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color("blue").opacity(0.1))
                            .cornerRadius(20)
                            //.shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            //.shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
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
                                    Text("Capacity")
                                        //.font(.caption.bold())
                                        .font(.system(size: 15)).bold()
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                    Color("blue3")
                                        .frame(width: 65, height: 2)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                Item(title: "ResourceName", value: resourceName, width: 120)
                                Item(title: "Capacity", value: capacity, width: 120)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .background(Color("blue").opacity(0.1))
                            .cornerRadius(20)
                            //.shadow(color: Color.black.opacity(0.08), radius: 5, x:5, y: 5)
                            //.shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
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
            
                k8sVM.pvInfo(resourceName: data.name)
            })
            .onReceive(k8sVM.$pvInfoData, perform: { value in
                self.uid = value?.detailPV.uid ?? "-"
                self.status = value?.resourcePV.status ?? "-"
                self.storageClass = value?.resourcePV.storageClass ?? "-"
                self.claim = value?.resourcePV.claim ?? "-"
                self.accessMode = value?.resourcePV.accessMode ?? ["-"]
                self.type = value?.sourcePV.type ?? "-"
                self.server = value?.sourcePV.server ?? "-"
                self.path = value?.sourcePV.path ?? "-"
                self.resourceName = value?.capacityPV.resourceName ?? "-"
                self.capacity = value?.capacityPV.capacity ?? "-"
            })
            .onDisappear(perform: {
                print(".onDisappear :: PV")
                k8sVM.currentPV = nil
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
