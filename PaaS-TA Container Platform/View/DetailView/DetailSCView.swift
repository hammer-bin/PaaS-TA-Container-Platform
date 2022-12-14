//
//  DetailSCView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/02.
//

import SwiftUI

struct DetailSCView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    @State var labels: [String] = []
    @State var annotations: [String] = []
    @State var provider: String = ""
    @State var archiveOnDelete: String = ""
    var body: some View {
        
        if let data = k8sVM.currentSC, k8sVM.showDetail {
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
                                    Text("UID")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    Text(uid)
                                        .font(.system(size: 15, design: .rounded))
                                        .lineLimit(2)
                                        .fontWeight(.medium)
                                }
                                
                                HStack{
                                    Text("Lables")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 90, alignment: .trailing)
                                    VStack(spacing: 3){
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
                                    VStack(spacing: 3){
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
                                    Text("provider")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(provider)")
                                        .font(.system(size: 15, design: .rounded))
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("archive_on_delete")
                                        .font(.caption.bold())
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                        .frame(width: 140, alignment: .trailing)
                                    Text("\(archiveOnDelete)")
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
                k8sVM.scInfo(resourceName: data.name)
            })
            .onReceive(k8sVM.$scInfoData, perform: { value in
                self.uid = value?.detailSc.uid ?? ""
                self.labels = value?.detailSc.labels ?? ["-"]
                self.annotations = value?.detailSc.annotations ?? ["-"]
                self.provider = value?.resourceSc.provider ?? ""
                self.archiveOnDelete = value?.resourceSc.archiveOnDelete ?? ""
            })
            .onDisappear(perform: {
                print(".onDisappear :: SC")
                k8sVM.currentSC = nil
            })
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            
        }
            
        
        
    }
}

struct DetailSCView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSCView()
    }
}
