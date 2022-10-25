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
            if let products = k8sVM.filterdResource {
                
                if products.isEmpty {
                    // No Results Found...
                    VStack(spacing: 10) {
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        
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
                            
                            // Staggered Grid...
                            // See my Staggered Video..
                            // Link in Bio...
                            //StaggeredGrid(columns: 2, spacing: 20, list: products) { product in
                            
                            // Card View...
                            ForEach(products, id:\.self){product in
                                SearchCardView(resource: product)
                            }
                            
                            //}
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
        .onAppear(perform: k8sVM.collectSearchData)
        
        
    }
    @ViewBuilder
    func SearchCardView(resource: String) -> some View {
        
        HStack(spacing: 10){
            Image(systemName: "chevron.right.square")
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height:30)
            
            VStack(content: {
                Text(resource)
                    .fontWeight(.bold)
                
                
            })
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: -5, y: -5)
        .onTapGesture {
            switch k8sVM.searchResource {
            case .pv:
                k8sVM.currentPV?.name = resource
            case .pvc:
                k8sVM.currentPVC?.name = resource
            case .svc:
                k8sVM.currentService?.name = resource
            case .pod:
                print("pod")
            case .deployment:
                print("dep")
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
