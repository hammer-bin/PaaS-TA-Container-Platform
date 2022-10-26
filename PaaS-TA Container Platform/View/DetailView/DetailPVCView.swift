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
    var body: some View {
        
        if let data = k8sVM.currentPVC, k8sVM.showDetail {
            ScrollView(.vertical, showsIndicators: false){

                VStack{
                    // MARK: - Detail Info
                    VStack{
                        
                        VStack{
                            HStack{
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
                                        .fontWeight(.medium)
                                }
                        
                                
                                HStack{
                                    Text("UID")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text(uid)
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
                                    Text("status")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(status)")
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("storageClass")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(storageClass)")
                                        .fontWeight(.medium)
                                }
                                
                                HStack{
                                    Text("storage")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(storage)")
                                        .fontWeight(.medium)
                                }
                                
                                HStack{
                                    Text("accessMode")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    ForEach(accessMode, id: \.self){ am in
                                        Text(am)
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
                k8sVM.pvcInfo(namespace: data.namespace, resourceName: data.name)
            })
            .onReceive(k8sVM.$pvcInfoData, perform: { value in
                self.uid = value?.detailPVC.uid ?? ""
                self.status = value?.resourcePVC.status ?? ""
                self.storageClass = value?.resourcePVC.storageClass ?? ""
                self.storage = value?.resourcePVC.capacity.storage ?? ""
                self.accessMode = value?.resourcePVC.accessMode ?? []
            })
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            
        }
            
        
        
    }
}