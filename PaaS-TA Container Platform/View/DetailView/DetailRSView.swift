//
//  DetailRSView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/11/08.
//

import SwiftUI

struct DetailRSView: View {
    @EnvironmentObject var k8sVM : K8sVM
    @State var uid: String = ""
    @State var labels: [String] = []
    @State var annotations: [String] = []
    @State var createdTime: String = ""
    @State var selector: [String] = []
    @State var image: [String] = []
    var body: some View {
        
        if let rsData = k8sVM.currentRS, k8sVM.showDetail {
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
                                
                                Item(title: "Name", value: rsData.name, width: 95)
                                Item(title: "Namespace", value: rsData.namespace, width: 95)
                                Item(title: "UID", value: uid, width: 95)
                                ItemList(title: "Labels", value: labels, width: 95)
                                ItemList(title: "Annotations", value: annotations, width: 95)
                                Item(title: "CreatedTime", value: createdTime, width: 95)
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
                                
                                ItemList(title: "Selector", value: selector, width: 90)
                                ItemList(title: "Image", value: image, width: 90)
 
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
                k8sVM.rsInfo(namespace: rsData.namespace, resourceName: rsData.name)
            })
            .onReceive(k8sVM.$rsInfoData, perform: { value in
                self.uid = value?.detailRS.uid ?? ""
                self.labels = value?.detailRS.labels ?? []
                self.annotations = value?.detailRS.annotations ?? []
                self.createdTime = value?.detailRS.createdTime ?? ""
                self.selector = value?.resourceRS.selector ?? []
                self.image = value?.resourceRS.image ?? []
            })
            .onDisappear(perform: {
                print(".onDisappear :: RS")
                k8sVM.currentRS = nil
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

struct DetailRSView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRSView()
    }
}
