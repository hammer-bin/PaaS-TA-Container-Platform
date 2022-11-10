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
                                    Text("UID")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text(uid)
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                }
                                
                                
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
                                
                                HStack{
                                    Text("status")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(status)")
                                        .font(.system(size: 15, design: .rounded))
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
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                }
                                
                                HStack{
                                    Text("claim")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(claim)")
                                        .font(.system(size: 15, design: .rounded))
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
                                            .font(.system(size: 15, design: .rounded))
                                            .fontWeight(.medium)
                                            //.clipShape(Rectangle())
                                    }
                                }
                                
                                
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
                    
                    // MARK: - Back Button
                    HStack{
                        
                        Button(action: {
                            withAnimation{
                                k8sVM.showDetail = false
                                if k8sVM.showDetailSearch {
                                    k8sVM.showDetailSearch = false
                                }
                            }
                        }) {
                            
                            HStack{
                                
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.white)
                                    //.padding(.leading)
                                
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
                        //.padding(.leading, 35)
                    }
                }
                
            }
            .onAppear(perform: {
            
                k8sVM.pvInfo(resourceName: data.name)
            })
            .onReceive(k8sVM.$pvInfoData, perform: { value in
                self.uid = value?.detailPV.uid ?? ""
                self.status = value?.resourcePV.status ?? ""
                self.storageClass = value?.resourcePV.storageClass ?? ""
                self.claim = value?.resourcePV.claim ?? ""
                self.accessMode = value?.resourcePV.accessMode ?? []
            })
            .onDisappear(perform: {
                print(".onDisappear :: PV")
                k8sVM.currentPV = nil
            })
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            
        }
            
        
        
    }
}
