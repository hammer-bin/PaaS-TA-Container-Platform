//
//  SearchView.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/10/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var k8sVM : K8sVM
    // Activating Text Field with the help of FocusState...
    @FocusState var startTF: Bool
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack{
            
            HStack(spacing: 20) {
                
                Button {
                    withAnimation{
                        k8sVM.searchActivated = false
                        k8sVM.searchText = ""
                        k8sVM.showDetailSearch = false
                        k8sVM.showDetail = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                // Search Bar...
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    // Since we need a seprate view for search bar...
                    TextField("Search", text: $k8sVM.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("Purple"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            // Showing Progress if searching
            // else showing no results found if empty...
            if let products = k8sVM.filterItem {
                
                if products.isEmpty {
                    // No Results Found...
                    VStack(spacing: 10) {
                        Image("NoData_gray")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
                        
                        Text("Item Not Found")
                            .font(.system(size: 22).bold())
                        
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.system(size: 16).bold())
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,30)
                    }
                    .padding()
                }
                else {
                    // Filter Result
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0) {
                            
                            // Found Text...
                            Text("Found \(products.count) results")
                                .font(.system(size: 24).bold())
                                .padding(.vertical)
                            
                            // Card View...
                            ForEach(products, id:\.self){product in
                                SearchCardView(resource: product.name, namespace: product.namespace ?? "")
                            }
                            .padding(.bottom, 10)
                        }
                        .padding()
                    }
                }
            }
            else {
                
                ProgressView()
                    .padding(.top, 30)
                    .opacity(k8sVM.searchText == "" ? 0 : 1)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color.white
                .ignoresSafeArea()
        )
        .onAppear(perform: k8sVM.collectSearchData)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
//        .overlay(
//            ZStack{
//                if k8sVM.searchResource == .pvc {
//                    DetailPVCView()
//                } else if k8sVM.searchResource == .deployment {
//                    DetailDeployView()
//                } else if k8sVM.searchResource == .pv {
//                    //ZStack{
//                        DetailPVView()
//                    //}
//
//
//                }
//            }
//            .frame(maxHeight: .infinity)
//            .background(
//                Color("blue")
//                    .opacity(0.3)
//                    .cornerRadius(12)
//                    .edgesIgnoringSafeArea(.bottom)
//            )
//            .padding()
//            .padding(.top, 50)
//
//        )
        
        
    }
    @ViewBuilder
    func SearchCardView(resource: String, namespace: String) -> some View {
        
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(resource)
                    .fontWeight(.bold)
                
                
            })
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(Color("blue").opacity(0.1))
        .cornerRadius(20)
//        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
//        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
        .onTapGesture {
            k8sVM.showDetail = true
            k8sVM.showDetailSearch = true
            print("searchResource   :: \(k8sVM.searchResource)")
            print("resource         :: \(resource)")
            print("namespace        :: \(namespace)")
            print("showDetail       :: \(k8sVM.showDetail)")
            print("showDetailSearch :: \(k8sVM.showDetailSearch)")
            switch k8sVM.searchResource {
            case .pv:
                k8sVM.currentPV = PVData(name: resource)
            case .pvc:
                k8sVM.currentPVC = PVCData(name: resource, namespace: namespace)
            case .svc:
                k8sVM.currentService = ServiceData(name: resource, namespace: namespace)
            case .pod:
                k8sVM.currentPod = PodData(name: resource, namespace: namespace)
            case .deployment:
                k8sVM.currentDeploy = DeployData(name: resource, namespace: namespace)
            case .sc:
                k8sVM.currentSC = SCData(name: resource)
            case .ingress:
                k8sVM.currentIngress = IngressData(name: resource, namespace: namespace)
            case .rs:
                k8sVM.currentRS = RSData(name: resource, namespace: namespace)
            }
            
            withAnimation(.easeInOut){
                
                k8sVM.showDetail = true
            }
        }
        
    }
}
    
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
