//
//  SideMenu.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/29.
//

import SwiftUI

struct SideMenu: View {
    @Binding var selectedTab: String
    @Namespace var animation
    @EnvironmentObject var k8sVM : K8sVM
    @State var namespaceData : [NamespaceData] = []
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            
            // Profile Pic...
            Image("anelli")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 70)
                .cornerRadius(10)
                .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 6, content: {

                Button(action: {}, label: {
                    Text("Namespace")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.5)
                })
            })
            
            Menu(content: {
                
                Button(action: {k8sVM.currentNS = "All"}) {
                    Text("All namespace")
                }
                ForEach(namespaceData) { datum in
                    NamespaceButton(namespaceName: datum.name)
                }
    
            }) {
                
                Label(title: {
                    Text(k8sVM.currentNS)
                        .foregroundColor(Color("blue"))
                }) {
                    Image(systemName: "rectangle.split.3x1")
                        .foregroundColor(Color("blue"))
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .frame(maxWidth: 240, alignment: .leading)
                .fontWeight(.semibold)
                .background(Color.white)
                .clipShape(Capsule())
            }
            
            // tab Button...
            VStack(alignment: .leading,spacing: 10){
                TabButton(image: "house", title: "Home", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "clock.arrow.circlepath", title: "Workload", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "bell.badge", title: "Service", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "gearshape.fill", title: "Storage", selectedTab: $selectedTab, animation: animation)
                
                TabButton(image: "questionmark.circle", title: "Help", selectedTab: $selectedTab, animation: animation)
            }
            .padding(.leading, -15)
            .padding(.top,50)
            
            Spacer()
            
            // Sign Out Button
            VStack(alignment: .leading, spacing: 6, content: {
                TabButton(image: "rectangle.righthalf.inset.fill.arrow.right", title: "Log out", selectedTab: .constant(""), animation: animation)
                    .padding(.leading, -15)
                
                Text("App Version 1.0.1")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0.6)
            })
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        // namespace 정보 호출 // 로그인시 1회 호출 방식으로 변경 예정
        .onAppear(perform: {
            print("ServiceView onAppear() called")
        })
        .onAppear(perform: { k8sVM.namespaceList()})
        .onReceive(k8sVM.$namespaces, perform: { self.namespaceData = $0 })
    }
    
    @ViewBuilder
    func NamespaceButton(namespaceName: String) -> some View {
        
        Button(action: {k8sVM.currentNS = namespaceName}) {
            Text(namespaceName)
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    var selectedTab : String = "Home"
    static var previews: some View {
        SideMenu(selectedTab: .constant("Home"))
    }
}
